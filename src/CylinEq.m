function [dx] = CylinEq(t, x, u, args)
% 柱坐标系运动方程

if size(x, 1) == 1
    x = x';
end
if size(u, 1) == 1
    u = u';
end

mu = args.mu;

r  = x(1);
% q  = x(2);
z  = x(3);
vr = x(4);
vq = x(5);
vz = x(6);
s  = sqrt(r * r + z * z);
s3 = s * s * s;

dx = x;
dx(1) = vr;
dx(2) = vq / r;
dx(3) = vz;
dx(4) = vq * vq / r - mu * r / s3;
dx(5) = -vr * vq / r;
dx(6) = -mu * z / s3;

dx(4 : 6) = dx(4 : 6) + u;

if length(x) == 9
    dx(7 : 9) = u - x(7 : 9);
end
end