function [dx] = SolarSailTimeOpt(t, x, p)
% 太阳帆轨道转移动力学(控制)方程(2D)

if size(x, 1) == 1
    x = x';
end

r       = x(1);
% theta   = x(2);
vr      = x(3);
vtheta  = x(4);

lr      = x(5);
ltheta  = x(6);
lvr     = x(7);
lvtheta = x(8);

if lvtheta ~= 0
    alpha = atan(-3 * lvr - sqrt(9 * lvr^2 + 8 * lvtheta^2) / (4 * lvtheta));
elseif lvr < 0
    alpha = 0;
else
    alpha = -pi / 2;
end

s = sin(alpha);
c = cos(alpha);

dx = x;
dx(1) = vr;
dx(2) = vtheta / r;
dx(3) = p.beta * c^3 / r^2 + vtheta^2 / r - 1 / r^2;
dx(4) = p.beta * s * c^2 / r^2 - vr * vtheta / r;
dx(5) = ltheta * vtheta / r^2 + lvr * (2 * p.beta * c^3 / r^3 + vtheta^2 / r^2 - 2 / r^3) ...
        + lvtheta * (2 * p.beta * s * c^2 / r^3 - vr * vtheta / r^2);
dx(6) = 0;
dx(7) = -lr + lvtheta * vtheta / r;
dx(8) = -ltheta / r - 2 * lvr * vtheta / r + lvtheta * vr / r;

end