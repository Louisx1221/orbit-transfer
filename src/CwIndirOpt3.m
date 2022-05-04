function [t, x] = CwIndirOpt3(rv0, n, f, tf, tspan)
% 固定推力C-W交会
% 燃料最优 J = \min \int F \mathrm{d} t

args.n = n;
args.f = f;
args.tspan = tspan;

% 初值
lambda0 = [pi / 2, 0.4, 0.0003, 0.0003, 0.004, -1]'; % 协态变量
tf0 = 0.9 * tf; % 转移时长
x0 = [lambda0; tf0];

ub = [2 * pi, 1e0 * ones(1, 5),  tf];
lb = [0,      -1e0 * ones(1, 5), 0.1 * tf];

options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-7,...
                    'Algorithm','sqp',...
                    'MaxFunEvals',10000000,'MaxIter',inf,...
                    'Display','iter','largescale','on',...
                    'PlotFcn','optimplotfvalconstr');

[x, fval, exitflag, output] = fmincon(@(x) CwJ(x, rv0, args), x0, [], [], [], [], lb, ub, @(x) CwCon(x, rv0, args), options)

x0 = [rv0; zeros(3, 1)];
args.lambda = x(1 : 6);
[t, x] = ode45(@(t, x) CwTpbvp(t, x, args), 0 : args.tspan : x(end), x0);

end

%% 性能指标
function [J] = CwJ(x, rv0, args)
% x:    lambda, tf
% args: n, f, tspan

x0 = [rv0; zeros(3, 1)];
args.lambda = x;
[t, x] = ode45(@(t, x) CwTpbvp(t, x, args), 0 : args.tspan : x(end), x0);

J = 0;
for i = 1 : length(t)
    J = J + norm(x(i, 7 : 9));
end
end

%% 边界条件
function [c, ceq] = CwCon(x, rv0, args)
% x:    lambda, tf
% args: n, f, tspan

x0 = [rv0; zeros(3, 1)];
args.lambda = x;
[~, x] = ode45(@(t, x) CwTpbvp(t, x, args), 0 : args.tspan : x(end), x0);

% 容许误差
tol = [1e2 1e2 1e2 1 1 1];
% 期望终端状态
rvf = zeros(1, 6);

c = abs(x(end, 1 : 6) - rvf) - tol;
ceq = [];
end

%% 两点边值问题
function [dx] = CwTpbvp(t, x, args)
% x: rv, u
% arg: n, f, tspan, lambda

[A, B] = Cw(args.n);

psi   = args.lambda(1);
rho   = args.lambda(2);
alpha = args.lambda(3);
beta  = args.lambda(4);
c1    = args.lambda(5);
c2    = args.lambda(6);

lambda_v = zeros(3, 1);
lambda_v(1) = rho * sin(args.n * t + psi) - 2 * c1;
lambda_v(2) = 2 * rho * cos(args.n * t + psi) + 3 * c1 * args.n * t + c2;
lambda_v(3) = alpha * sin(args.n * t + psi) + beta * sin(args.n * t + psi);

% 开关函数
% u = -lambda_v / norm(lambda_v) * args.f;
if 1 - norm(lambda_v) < 0
    u = -lambda_v / norm(lambda_v) * args.f;
else
    u = zeros(3, 1);
end

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
dx(7 : 9) = u - x(7 : 9);
end
