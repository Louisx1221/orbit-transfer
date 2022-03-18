function [t, x] = CwRendezvousLowThrust(x0, n, tf, step)
% 连续推力C-W交会
% 燃料最优 J = \min \int \sum a_i ^ 2 \mathrm{d} t / 2

% 状态转移矩阵
[~, B] = Cw(n);
Phif = CwPhi(n, tf);
Phi0 = CwPhi(n, 0);
phi0 = Phif * B * Phi0(:, 4 : 6)';

[~, phi] = ode45(@(t, phi) CwPhiEq(t, phi, n, tf), 0 : step : tf, phi0);

phif = zeros(6);
for i = 1 : 6
    phif(:, i) = -phi(end, 6 * (i - 1) + (1 : 6))';
end

% 协态变量初始值
lambda0 = -(Phif * x0 \ phif)';
% xf = [0., 0., 0., 0., 0., 0.]';
% lambda0 = ((Phif * x0 - xf) \ phi_int)';

[t, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);
end