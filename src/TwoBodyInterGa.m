function [sp, se, lambda, tf] = TwoBodyInterGa(xp, xe, tf, ap)
% 二体拦截(时间最优)

if ~isfield(ap, 'tspan')
    ap.tspan = 1e-4 * tf;
end

lb = [-1e2 * ones(6, 1); 0.8 * tf];
ub = [1e2 * ones(6, 1); 1.2 * tf];

options = optimoptions('ga', 'Display', 'iter', 'Generations', 100, 'PlotFcn', @gaplotbestf);
[x] = ga(@(x) Cost(x, xp, xe, ap),7,[],[],[],[],lb,ub,[], options);

tf = x(end);
lambda = x(1 : 6)';

xp = [xp; lambda];
[t, s] = ode45(@(t, x) TwoBodyTimeOpt(t, x, ap), 0 : ap.tspan : tf, xp);
u = zeros(length(t), 3);
for i = 1 : length(t)
    u(i, 1 : 3) = -s(i, 10 : 12) / norm(s(i, 10 : 12));
end
sp = [t, s, u];

[t, s] = ode45(@(t, x) TwoBodyEq(t, x, zeros(3, 1), ap), 0 : ap.tspan : tf, xe);
se = [t, s];
end

%% 性能指标
function [J] = Cost(x, xp, xe, ap)

tf = x(end);
lambda = x(1 : 6)';

xp = [xp; lambda];
[~, sp] = ode45(@(t, x) TwoBodyTimeOpt(t, x, ap), 0 : ap.tspan : tf, xp);
[~, se] = ode45(@(t, x) TwoBodyEq(t, x, zeros(3, 1), ap), 0 : ap.tspan : tf, xe);

% 脱靶量
% x
J = norm(sp(end, 1 : 3) - se(end, 1 : 3));
J = J * 1e1;
% lambda
J = J + norm(sp(end, 10 : 12));
% Hf
J = J + abs(1 + sp(end, 7 : 9) * sp(end, 4 : 6)');
end