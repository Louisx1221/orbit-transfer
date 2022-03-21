function [dx] = CwOptEq(t, x, n, lambda0)
% C-W交会最优控制方程

[A, B] = Cw(n);

Phi = CwPhi(n, -t).';
tau = -B' * Phi * lambda0;

dx = A * x + B * tau;
% dx = A * x;
end