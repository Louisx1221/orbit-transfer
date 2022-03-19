function [t, x] = CwRendezvousLowThrust(x0, n, tf, step)
% 连续推力C-W交会
% 燃料最优 J = \min \int \sum a_i ^ 2 \mathrm{d} t / 2

% 状态转移矩阵
[~, B] = Cw(n);
Phif = CwPhi(n, tf);
Phi0 = CwPhi(n, 0);
Psi0 = Phif * B * Phi0(:, 4 : 6)';

Psi0 = zeros(6);

[~, Psi] = ode45(@(t, x) CwPsiEq(t, x, n, tf), 0 : step : tf, Psi0);

Psif = zeros(6);
for i = 1 : 6
    Psif(:, i) = Psi(end, 6 * (i - 1) + (1 : 6))';
end

% 协态变量初始值
lambda0 = -(Phif * x0 \ Psif)';
% xf = [0., 0., 0., 0., 0., 0.]';
% lambda0 = ((Phif * x0 - xf) \ phi_int)';

[t, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);
end