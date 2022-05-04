function [A, B] = HmTSysCtrlMat(t, cr, cq, cz, x0, xf, p)
% 形状法(HM, t)标称轨道相动力学(系统矩阵, 控制矩阵)

% 形函数
r = x0(1) + cr(1) * t + cr(2) * t.^2 / 2 + cr(3) * t.^3 / 3;
z = x0(3) + cz(1) * t + cz(2) * t.^2 / 2 + cz(3) * t.^3 / 3;
% q数值积分求解
if t > 0
    [~, qt] = ode45(@(t, x) QEq(t, x, x0(1), cr, cq), 0 : t * 1e-3 : t, x0(2));
    q = qt(end);
else
    q = x0(2);
end
vr = cr(1) + cr(2) * t + cr(3) * t.^2;
vq = cq(1) + cq(2) * t + cq(3) * t.^2;
vz = cz(1) + cz(2) * t + cz(3) * t.^2;
x_nom = [r, q, z, vr, vq, vz]';

% 雅可比矩阵
M = CylinJacMat(x_nom, p.mu); % 系统矩阵
A = [M, diag([zeros(1, 3), -p.Isp * p.g0 * p.Tmax / 2 / p.m0 / p.m0 * ones(1, 3)]);
     zeros(6), -M'];

% 修正推力
dx_norm = [vr, vq / r, vz, cr(2) + 2 * cr(3) * t, cq(2) + 2 * cq(3) * t, cz(2) + 2 * cz(3) * t]';
dx = CylinEq(0, x_nom, 0, p);
a = dx_norm - dx;
% 控制矩阵
B = [zeros(3, 1); a(4 : 6); zeros(6, 1)];
end

%% q方程
function [dq] = QEq(t, q, r0, cr, cq)

r = r0 + cr(1) * t + cr(2) * t^2 / 2 + cr(3) * t^3 / 3;
dq = (cq(1) + cq(2) * t + cq(3) * t^2) / r;
end