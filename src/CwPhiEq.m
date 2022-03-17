function [dx] = CwPhiEq(t, x, n, tf)
% C-W协态变量状态方程

phi = CwPhi(n, tf - t);
[~, b] = Cw(n);

phi_l = CwPhi(n, -t)';
phi_dot = phi * b * phi_l(4 : 6, :);

dx = x;
for i = 1 : 6
    dx(6 * (i - 1) + (1 : 6)) = phi_dot(i, :)';
end
end