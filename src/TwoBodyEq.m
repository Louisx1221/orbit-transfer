function [dx] = TwoBodyEq(t, x, u, ap)
% 二体模型状态方程

if size(x, 1) == 1
    x = x';
end
if size(u, 1) == 1
    u = u';
end

r = x(1 : 3);
v = x(4 : 6);
r_ = norm(r);
r3 = r_ * r_ * r_;

dx = x;
dx(1 : 3) = v;
dx(4 : 6) = -ap.MU / r3 * r + u;
end