function [sol, x_nlp, fval, exitflag, output, lambda, ct] = Gpm(x0, xf, DynEq, sol0, lb_, ub_, N, args)
% 高斯伪谱法

tau = GaussNodes(N);
D = GaussDiffMat(tau);
w = GaussWeights(tau);
% x_nlp0 = zeros((dim_x + dim_u) * N + 1, 1);
dim = length(lb_) - 1;
tf = sol0(end, 1);
x_nlp0 = interp1(sol0(:, 1), sol0(:, 1 + (1 : dim)), (tau + 1) * tf / 2);
x_nlp0 = Mat2Vec(x_nlp0);
x_nlp0 = [x_nlp0'; tf];
lb = zeros(length(x_nlp0), 1);
ub = zeros(length(x_nlp0), 1);
for i = 1 : N
    lb((i - 1) * dim + (1 : dim)) = lb_(1 : dim);
    ub((i - 1) * dim + (1 : dim)) = ub_(1 : dim);
end
lb(end) = lb_(end);
ub(end) = ub_(end);
tic;
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',1000,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x_nlp, fval, exitflag, output, lambda] = fmincon(@(x_nlp) GaussJ(x_nlp), x_nlp0, [], [], [], [], lb, ub, @(x_nlp) GaussCon(x_nlp, x0, xf, DynEq, D, w, args), options);
ct = toc;
x_nlp_ = Vec2Mat(x_nlp(1 : end - 1), dim);
sol = Lagrange(tau, x_nlp_, sol0(:, 1));
sol = [sol0(:, 1), sol];
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
%     m = size(x, 2);
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

%% 性能指标
function [J] = GaussJ(x_nlp)
    J = x_nlp(end);
end

%% 约束
function [c, ceq] = GaussCon(x_nlp, x0, xf, DynEq, D, w, args)
% 输入: xut   高斯点状态
%       DynEq 动力学方程
%       D   微分约束矩阵
% 输出：c   不等式约束
%       ceq 等式约束

tf = x_nlp(end);
N = size(D, 1); % 高斯点个数N + 2
n = length(x0); % 状态变量维度
m = (length(x_nlp) - 1) / N - n; % 控制变量维度
% 状态变量
x_nlp = Vec2Mat(x_nlp(1 : end - 1), m + n);
x = x_nlp(:, 1 : n);
u = x_nlp(:, n + 1 : end);

% 等式约束(dim_x * N + dim_x)：动力学方程约束，终端约束
ceq = zeros(n * N + n, 1);
% 动力学方程
f = zeros(N, n);
for i = 1 : N
    f(i, :) = DynEq([], x(i, :), u(i, :), args);
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