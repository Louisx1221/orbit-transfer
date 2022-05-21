function [A, B] = HmSysCtrlMat(s, cr, ct, cz, x0, xf, p)
% 形状法(HM, )标称轨道相动力学(系统矩阵, 控制矩阵)

% 形函数
qs = x0(2) + s * (xf(2) - x0(2));
rs = x0(1) + cr(1) * s + cr(2) * s.^2 / 2 + cr(3) * s.^3 / 3;
% ts = ct(1) * s + ct(2) * s.^2 / 2 + ct(3) * s.^3 / 3;
zs = x0(3) + cz(1) * s + cz(2) * s.^2 / 2 + cz(3) * s.^3 / 3;
dtds = ct(1) + ct(2) * s + ct(3) * s.^2;
% 速度分量
vqs = (xf(2) - x0(2)) * rs / dtds;
vrs = (cr(1) + cr(2) * s + cr(3) * s.^2) / dtds;
vzs = (cz(1) + cz(2) * s + cz(3) * s.^2) / dtds;
xs = [rs, qs, zs, vrs, vqs, vzs]';

% 雅可比矩阵
M = CylinJacMat(xs, p.mu);
F = [M, diag([zeros(1, 3), -p.Isp * p.g0 / 2 / p.m0 / p.m0 * ones(1, 3)]);
     zeros(6), -M'];
% 系统矩阵
A = F * dtds;

% 修正推力
dr = vrs;
dq = vqs / rs;
dz = vzs;
dvr = (cr(3) * s  * (2 * ct(1) + ct(2) * s) - cr(1) * (ct(2) + 2 * ct(3) * s) + ...
    cr(2) * (ct(1) - ct(3) * s.^2)) / dtds^2 / dtds;
dvq = ((cr(1) + s  * (cr(2) + cr(3) * s)) * (ct(1) + s * (ct(2) + ct(3) * s)) - ...
    (ct(2) + 2 * ct(3) * s) * (x0(1) + cr(1) * s + cr(2) * s.^2 / 2 + cr(3) * s.^3 / 3)) * ...
    (xf(2) - x0(2)) / dtds^2 / dtds;
dvz = (cz(3) * s  * (2 * ct(1) + ct(2) * s) - cz(1) * (ct(2) + 2 * ct(3) * s) + ...
    cz(2) * (ct(1) - ct(3) * s.^2)) / (ct(1) + s * (ct(2) + ct(3) * s))^2  / dtds;
dx_nom = [dr, dq, dz, dvr, dvq, dvz]';
dxt = CylinEq(0, xs, 0, p);
a = (dx_nom - dxt) * dtds;
% a = dx_nom - dxt;
% 控制矩阵
f = [zeros(3, 1); a(4 : 6); zeros(6, 1)];
B = f * dtds;
end