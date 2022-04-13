function [sol, x_nlp, fval, exitflag, output, ct] = Gpm(x0, xf, Cost, DynEq, sol0, lb_, ub_, N, p)
% 高斯伪谱法

tau = GaussNodes(N);
D = GaussDiffMat(tau);
w = GaussWeights(tau);
dim = length(lb_);
tf = sol0(end, 1);
x_nlp0 = interp1(sol0(:, 1), sol0(:, 1 + (1 : dim)), (tau + 1) * tf / 2);
x_nlp0 = Mat2Vec(x_nlp0);
x_nlp0 = x_nlp0';
lb = zeros(length(x_nlp0), 1);
ub = zeros(length(x_nlp0), 1);
for i = 1 : N
    lb((i - 1) * dim + (1 : dim)) = lb_(1 : dim);
    ub((i - 1) * dim + (1 : dim)) = ub_(1 : dim);
end
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',1000,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
tic;
[x_nlp, fval, exitflag, output] = fmincon(@(x_nlp) NlpCost(x_nlp, tau, Cost, dim, x0, tf, p.tspan), x_nlp0, [], [], [], [], lb, ub, @(x_nlp) NlpCon(x_nlp, x0, xf, tf, DynEq, D, w, p), options);
ct = toc;
sol = NlpResult(x_nlp, tau, dim, x0, tf, p.tspan);
end

%% 高斯配点
function [tau] = GaussNodes(N)
% 输入：N   勒让德多项式的阶
% 输出：tau 高斯配点

n = 1 : N - 1;
d = n ./ sqrt(4 * n .^ 2 - 1);
J = diag(d, 1) + diag(d, -1);
tau = sort(eig(sparse(J)));
end

%% 微分约束矩阵
function [D] = GaussDiffMat(tau)
% 输入: tau 高斯配点
% 输出：D   微分约束矩阵

N = length(tau);
tau = [-1; tau];

%计算朗格朗日微分约束矩阵
D = zeros(N, N + 1);
for k = 2 : N + 1
    for i = 1 : N + 1
        for l = 1 : N + 1
            if l == i
                continue
            end
            d_kil = 1;
            for j = 1 : N + 1
                if j == i
                    continue
                end
                d_kil = d_kil / (tau(i) - tau(j));
                if j == l
                    continue
                end
                d_kil = d_kil * (tau(k) - tau(j));
            end
            D(k - 1, i) = D(k - 1, i) + d_kil;
        end
    end
end
end

%% 高斯权重
function [w] = GaussWeights(tau)
% 输入: tau 高斯配点
% 输出：w   高斯权重

N = length(tau);
Pnn = legendre(N, tau);
Pn1 = Pnn(2, :);
Pndot = -Pn1' ./ sqrt(1 - tau .^ 2);
w =  2 ./ Pndot .^2 ./ (1 - tau .^ 2);
end

%% 拉格朗日插值
function [x] = Lagrange(tau_, x_, t)
tau = 2 * (t - t(1)) / (t(end) - t(1)) - 1;
n_ = length(tau_);
n = length(tau);
L = ones(n, n_);
for k = 1 : n
    for i = 1 : n_
        for j = 1 : n_
            if j == i
                continue
            end
            L(k, i) = L(k, i) * (tau(k) - tau_(j));
            L(k, i) = L(k, i) / (tau_(i) - tau_(j));
        end
    end
end
x = L * x_;
end

%% 非线性规划问题结果
function [sol, tf] = NlpResult(x_nlp, tau, dim, x0, tf, tspan)
t = (0 : tspan : tf)';
dim_x = length(x0);
dim_u = dim - dim_x;
x_nlp_ = Vec2Mat(x_nlp, dim);
sol_x = Lagrange([-1; tau], [x0'; x_nlp_(:, 1 : dim_x)], t);
sol_u = Lagrange(tau, x_nlp_(:, 1 + dim_x : end), t(2 : end));
sol_u = [sol_u, t(2 : end)];
for i = 1 : length(t) - 1
    sol_u(i, end) = norm(sol_u(i, 1 : dim_u));
end
sol = [t, sol_x, [zeros(1, dim_u + 1); sol_u]];
end

%% 非线性规划问题性能指标
function [J] = NlpCost(x_nlp, tau, Cost, dim, x0, tf, step)
    sol = NlpResult(x_nlp, tau, dim, x0, tf, step);
    J = Cost(sol, tf);
end

%% 非线性规划问题约束
function [c, ceq] = NlpCon(x_nlp, x0, xf, tf, DynEq, D, w, p)
% 输入: xut   高斯点状态
%       DynEq 动力学方程
%       D   微分约束矩阵
% 输出：c   不等式约束
%       ceq 等式约束

N = size(D, 1); % 高斯点个数N + 2
n = length(x0); % 状态变量维度
m = length(x_nlp) / N - n; % 控制变量维度
% 状态变量
x_nlp = Vec2Mat(x_nlp, m + n);
x = x_nlp(:, 1 : n);
u = x_nlp(:, n + 1 : end);

% 等式约束(dim_x * N + dim_x)：动力学方程约束，终端约束
ceq = zeros(n * N + n, 1);
% 动力学方程
f = zeros(N, n);
for i = 1 : N
    f(i, :) = DynEq([], x(i, :), u(i, :), p);
end
% 动力学方程约束
for i = 1 : n
    ceq((i - 1) * N + (1 : N)) = D(:, 1) * x0(i) + D(:, 2 : end) * x(:, i) - tf / 2 * f(:, i);
end
% 终端约束
ceq(n * N + (1 : n)) = xf - x0 - tf / 2 * f' * w;

% 不等式约束
c = [];
end