function [cr, cq, cz] = ShapeBaseHmT(x0, xf, tf)
% 形状法(基函数, t)
% c1 + c2 * t + c3 * t^2

r0 = x0(1);
q0 = x0(2);
z0 = x0(3);
vr0 = x0(4);
vq0 = x0(5);
vz0 = x0(6);
rf = xf(1);
qf = xf(2);
zf = xf(3);
vrf = xf(4);
vqf = xf(5);
vzf = xf(6);

c = [1, 0, 0;
      -4, -2, 6;
      3, 3, -6];
cr = c * [vr0 vrf (rf - r0) / tf]' .* [1 1/tf 1/tf^2]';
cz = c * [vz0 vzf (zf - z0) / tf]' .* [1 1/tf 1/tf^2]';
% vq数值积分求解
[~, C] = ode45(@(t, x) CqEq(t, x, tf, r0, cr, vq0, vqf), 0 : tf * 1e-3 : tf, [0 0]');
cq3 = (qf - q0 - C(end, 2)) / C(end, 1);
cq1 = vq0;
cq2 = (vqf - vq0) / tf - cq3 * tf;
cq = [cq1 cq2 cq3]';
end

%% q参数方程
function [dx] = CqEq(t, x, tf, r0, cr, vq0, vqf)

r = r0 + cr(1) * t + cr(2) * t^2 / 2 + cr(3) * t^3 / 3;
dx = x;
dx(1) = t * (t - tf) / r;
dx(2) = (vqf * t + vq0 * (tf - t)) / r / tf;
end