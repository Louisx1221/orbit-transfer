function [t, x] = CwRendezvousLowThrust(x0, n, tf, step)
% 连续推力C-W交会
% 燃料最优 J = \min \int \sum a_i ^ 2 \mathrm{d} t / 2

% 状态转移矩阵
phif = CwPhi(n, tf);
phi0 = [];
for  i = 1 : 6
    phi0 = [phi0 phif(i, :)];
end

[~, phi] = ode45(@(t, phi) CwPhiEq(t, phi, n, tf), 0 : step : tf, phi0');

phi_int = phif;
for i = 1 : 6
    phi_int(i, :) = phi(end, 6 * (i - 1) + (1 : 6));
end

% xf = [0., 0., 0., 0., 0., 0.]';
% lambda0 = ((phif * x0 - xf) \ phi_int)';
lambda0 = (phif * x0 \ phi_int)';

[t, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);

end