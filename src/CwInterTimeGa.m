function [sp, l0, tf] = CwInterTimeGa(x0, tf, ap)
% C-W拦截(时间最优)

if ~isfield(ap, 'tspan')
    ap.tspan = 1e-4 * tf;
end

if ~isfield(ap, 'tspan')
    ap.tspan = 1e-4 * tf;
end

ap.x0 = x0;

lb = [-1e2 * ones(3, 1); 0.5 * tf];
ub = [1e2 * ones(3, 1); 1.0 * tf];

options = optimoptions('ga', 'PopulationSize', 100, 'Display', 'iter', 'PlotFcn', @gaplotbestf);
[x] = ga(@(x) Cost(x, ap),4,[],[],[],[],lb,ub,[], options);

tf = x(end);
lrf = x(1 : 3);
l0 = Lambda0(lrf, ap.n, tf);

x0 = [x0; l0];
[t, s] = ode45(@(t, x) CwTimeOpt(t, x, ap), 0 : ap.tspan : tf, x0);
[~, B] = Cw(ap.n);
u = zeros(length(t), 3);
for i = 1 : length(t)
    u(i, 1 : 3) = -(B' * s(i, 7 : 12)' / norm(B' * s(i, 7 : 12)'))';
end
sp = [t, s, u];
end

%% 性能指标
function [J] = Cost(x, ap)
% x: [lambda, tf]

tf = x(end);
lrf = x(1 : 3);
l0 = Lambda0(lrf, ap.n, tf);

x0 = [ap.x0; l0];
[~, x] = ode45(@(t, x) CwTimeOpt(t, x, ap), 0 : ap.tspan : tf, x0);

% 脱靶量
J = norm(x(end, 1 : 3))^2;
J = J + (x(end, 7 : 9) * x(end, 4 : 6)' + 1)^2;
end

%% 协态变量初值
function [l0] = Lambda0(lrf, n, tf)
% 协态变量满足 lambda_v(tf) == 0

if size(lrf, 1) == 1
    lrf = lrf';
end
lf = [lrf; zeros(3, 1)];

Phi = CwPhi(n, -tf);
Phi = Phi';

l0 = Phi \ lf;
end