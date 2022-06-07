function [dv, dv0, dvf] = Cw2Impulse(n, x0, tof, varargin)
%
% 相对运动交会(C-W方程)
%
% 输入:
% n         轨道角速度         (rad/s)
% x0        初始相对位置速度   (m, m/s)
% tof       转移时长           (s)
% xf        目标相对位置速度   (m, m/s)    可缺省，默认为0
%
% 输出:
% dv        所需总速度脉冲     (m/s)
% dv0       第一次速度脉冲     (m/s)
% dvf       第二次速度脉冲     (m/s)
%
% 参考：
% Orbital Mechanics for Engineering Students, 4th, Howard Curtis, p369-370

%% 输入
if size(x0, 1) == 1
    x0 = x0';
end
r0 = x0(1 : 3);
v0 = x0(4 : 6);

if isempty(varargin)
    rf = zeros(3, 1);
    vf = zeros(3, 1);
else
    xf = varargin{1};
    if size(xf, 1) == 1
        xf = xf';
    end
    rf = xf(1 : 3);
    vf = xf(4 : 6);
end

%% 双脉冲
% C-W
nt = n * tof;
phi_rr = [4 - 3 * cos(nt) 0 0;
    6 * (sin(nt) - nt) 1 0;
    0 0 cos(nt)];
phi_rv = [sin(nt) / n (1 - cos(nt)) * 2 / n 0;
    (cos(nt) - 1) * 2 / n (4 * sin(nt) - 3 * nt) / n 0;
    0 0 sin(nt) / n];
phi_vr = [3 * n * sin(nt) 0 0;
    6 * n * (cos(nt) - 1) 0 0;
    0 0 -n * sin(nt)];
phi_vv = [cos(nt) 2 * sin(nt) 0;
    -2 * sin(nt) 4 * cos(nt) - 3 0;
    0 0 cos(nt)];
% 脉冲
v0_ = phi_rv \ (rf - phi_rr * r0);
vf_ = phi_vr * r0 + phi_vv * v0_;
dv0 = v0_ - v0;
dvf = vf - vf_;
dv  = [norm(dv0) + norm(dvf) norm(dv0) norm(dvf)];
end