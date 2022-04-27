function [m] = CylinJacMat(x, mu)
% 柱坐标系雅克比矩阵

r  = x(1);
% q  = x(2);
z  = x(3);
vr = x(4);
vq = x(5);
% vz = x(6);
s  = sqrt(r * r + z * z);
r2 = r * r;
s2 = s * s;
s5 = s * s * s * s * s;

m = [0, 0, 0, 1, 0, 0;
     -vq / r2, 0, 0, 0, 1 / r, 0;
     0, 0, 0, 0, 0, 1;
     -vq * vq / r2 + mu * (3 * r2 - s2) / s5, 0, 3 * mu * r * z / s5, 0, 2 * vq / r, 0;
     vr * vq / r2, 0, 0, -vq / r, -vr / r, 0;
     3 * mu * r * z / s5, 0, mu * (3 * z * z - s2) / s5, 0, 0, 0];
end