function [dx] = CwPhiEq(t, x)
% C-W协态变量状态方程

n = x(1);

phi = CwPhi(n, t);
[~, b] = Cw(n);
phi_lv = CwPhiLv(n, t);

phi_dot = phi * b * phi_lv;
dx = x;
dx(1) = 0;
for i = 1 : 6
    dx(1 + 6 * (i - 1) + 1 : 6) = phi_dot(i, :);
end
end