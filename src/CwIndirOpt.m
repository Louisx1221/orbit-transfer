function [t, x] = CwInDirOpt(x0, n, tf, step)
% 连续推力C-W交会
% 燃料最优 J = \min \int \sum a_i ^ 2 \mathrm{d} t / 2

P = CwRiccati(n, tf, step);

lambda0 = P * x0;

[t, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);

end