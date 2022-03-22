function [t, x] = CwDirOpt(x0, n, tf, step, varargin)
% 连续推力C-W交会(直接法)
% 燃料最优 J = \min \int \sum a_i ^ 2 \mathrm{d} t / 2

% 节点数
if isempty(varargin)
    N = 11;
else
    N = varargin{1};
end

x0 = [x0; zeros(3, 1)];
ub = 0.02 * ones(1, 3 * N);
lb = -ub;

options = optimoptions('fmincon','Algorithm','sqp', 'MaxIterations', 1e4);
u = fmincon(@(u) CwDirJ(x0, n, tf, step, u), zeros(1, 3 * N), [], [], [], [], lb, ub, [], options);

[t, x] = ode45(@(t, x) CwDirEq(t, x, n, tf, u), 0 : step : tf, x0);
end

function [J] = CwDirJ(x0, n, tf, step, u)
% 支付函数

[t, x] = ode45(@(t, x) CwDirEq(t, x, n, tf, u), 0 : step : tf, x0);
a = zeros(length(t), 1);
for i = 1 : length(t)
    a(i) = norm(x(i, 7 : 9));
    a(i) = a(i) * a(i) / 2;
end

J = norm(x(end, 1 : 3)) + 1e2 * norm(x(end, 4 : 6)) + sum(a) / length(t) * tf;
end

function [dx] = CwDirEq(t, x, n, tf, u)
% 线性插值

[A, B] = Cw(n);

% 分段数 = 节点数 - 1
N = length(u) / 3 - 1;
i = floor(N * t / tf);
if i == N
    tau = u(3 * i + (1 : 3))';
else
    k = (i + 1) - N * t / tf;
    tau = u(3 * i + (1 : 3))' * k + u(3 * (i + 1) + (1 : 3))' * (1 - k);
end

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * tau;
if length(x) == 9
    dx(7 : 9) = tau - x(7 : 9);
end
end