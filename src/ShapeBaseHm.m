function [cr, ct, cz] = ShapeBaseHm(x0, xf, tf)
% 形状法(基函数, theta = q -> s)
% s = (q - qf) / (qf - q0)
% c1 + c2 * s + c3 * s^2

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
cr = c * [r0 * vr0 / vq0 * (qf - q0);
          rf * vrf / vqf * (qf - q0);
          rf - r0];
ct = c * [r0 / vq0 * (qf - q0);
          rf / vqf * (qf - q0);
          tf];
cz = c * [z0 * vz0 / vq0 * (qf - q0);
          zf * vzf / vqf * (qf - q0);
          zf - z0];
end