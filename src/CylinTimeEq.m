function [dx] = CylinTimeEq(t, x, ap)
% 柱坐标系时间最优控制方程

if size(x, 1) == 1
    x = x';
end

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
dx(4) = vq * vq / r - ap.mu * r / s3;
dx(5) = -vr * vq / r;
dx(6) = -ap.mu * z / s3;

if length(x) == 12
    lambda = x(7 : 12);
    u = -ap.Tmax / ap.m0 * lambda(4 : 6) / norm(lambda(4 : 6));

    dx(4 : 6) = dx(4 : 6) + u;
    Jf = CylinJacMat(x, ap.mu);
    dx(7 : 12) = -Jf' * lambda;
end

end