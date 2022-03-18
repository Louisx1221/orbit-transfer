function [dx] = CwPsiEq(t, x, n, tf)
% C-W协态变量状态方程

% Phi = CwPhi(n, tf - t);
[~, B] = Cw(n);

Phi_l = CwPhi(n, -t)';
% phi_dot = Phi * b * Phi_l(4 : 6, :);
Psi_dot = -B * Phi_l(4 : 6, :);

dx = x;
for i = 1 : 6
    dx(6 * (i - 1) + (1 : 6)) = Psi_dot(:, i);
end
end