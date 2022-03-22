function [dx] = CwOptEq(t, x, n, lambda0)
% C-W交会最优控制方程

[A, B] = Cw(n);

Phi = CwPhi(n, -t).';
tau = -B' * Phi * lambda0;

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * tau;
% dx = A * x;

if length(x) == 9
    dx(7 : 9) = tau - x(7 : 9);
end
end