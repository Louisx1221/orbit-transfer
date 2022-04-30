function [A, B] = HmSysCtrlMat(s, cr, ct, cz, x0, xf, p)

% 形函数
sq = x0(2) + s * (xf(2) - x0(2));
sr = x0(1) + cr(1) * s + cr(2) * s.^2 / 2 + cr(3) * s.^3 / 3;
% st = ct(1) * s + ct(2) * s.^2 / 2 + ct(3) * s.^3 / 3;
sz = x0(3) + cz(1) * s + cz(2) * s.^2 / 2 + cz(3) * s.^3 / 3;
dtds = ct(1) + ct(2) * s + ct(3) * s.^2;
% v表示对t求导
svq = (xf(2) - x0(2)) / dtds;
svr = (cr(1) + cr(2) * s + cr(3) * s.^2) / dtds;
svz = (cz(1) + cz(2) * s + cz(3) * s.^2) / dtds;
xs = [sr, sq, sz, svr, svq, svz]';

% 雅可比矩阵
M = CylinJacMat(xs, p.mu);
F = [M, diag([zeros(1, 3), -p.Isp * p.g0 / 2 / p.m0 / p.m0 * ones(1, 3)]);
     zeros(6), -M'];
% 系统矩阵
A = F * dtds;

% 修正推力
dxs = [svr, svq, svz, [cr(2) + 2 * cr(3) * s, 0, cz(2) + 2 * cz(3) * s] / dtds / dtds]';
dxt = CylinEq(0, xs, 0, p);
a = (dxs - dxt) * dtds ;
% 控制矩阵
B = [zeros(3, 1); a(4 : 6); zeros(6, 1)];
end