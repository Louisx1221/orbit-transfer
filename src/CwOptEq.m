function [dx] = CwOptEq(t, x, n, lambda0)
% C-W交会最优控制方程

[a, b] = Cw(n);

phi_l = CwPhi(n, -t)';
tau = phi_l(4 : 6, :) * lambda0;

dx = a * x + b * tau;

end