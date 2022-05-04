function [dx] = CylinEnergyEq(t, x, p)
% 柱坐标系运动方程

if size(x, 1) == 1
    x = x';
end

r  = x(1);
% q  = x(2);
z  = x(3);
vr = x(4);
vq = x(5);
vz = x(6);
lambda = x(7 : 12);
s  = sqrt(r * r + z * z);
s3 = s * s * s;

dx = x;
dx(1) = vr;
dx(2) = vq / r;
dx(3) = vz;
dx(4) = vq * vq / r - p.mu * r / s3;
dx(5) = -vr * vq / r;
dx(6) = -p.mu * z / s3;

u = -p.Isp * p.g0 * p.Tmax / 2 / p.m0 / p.m0 * lambda(4 : 6);
% a = 4e-4 m/s^2; 2.6738e-15 AU/s^2 

dx(4 : 6) = dx(4 : 6) + u;
Jf = CylinJacMat(x, p.mu);
dx(7 : 12) = -Jf' * lambda;

if length(x) >= 15
    dx(13 : 15) = u - x(13 : 15);
    if length(x) == 16
        dx(16) = norm(u) - x(16);
    end
end
end