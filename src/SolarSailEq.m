function [dx] = SolarSailEq(t, x, u, p)
% 太阳帆轨道转移动力学(控制)方程(2D)

if size(x, 1) == 1
    x = x';
end
if size(u, 1) == 1
    u = u';
end

r      = x(1);
% theta  = x(2);
vr     = x(3);
vtheta = x(4);

alpha  = u(1);

dx = x;
dx(1) = vr;
dx(2) = vtheta / r;
dx(3) = p.beta * cos(alpha)^3 / r^2 + vtheta^2 / r - 1 / r^2;
dx(4) = p.beta * sin(alpha) * cos(alpha)^2 / r^2 - vr * vtheta / r;

end