function [t, x, lambda0] = CwDirOpt(x0, n, tf, step)
% 连续推力C-W交会(直接法)
lambda0 = ga(@(lambda0) CwDirOptRes(x0, n, tf, step, lambda0), 6, [], [], [], [], -1 * ones(1, 6), 1 * ones(1, 6));
lambda0 = lambda0';
[t, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);
end

function [dis] = CwDirOptRes(x0, n, tf, step, lambda0)
lambda0 = lambda0';
[~, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);
dis = norm(x(end, :));
end