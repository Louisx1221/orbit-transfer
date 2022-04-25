function [dv, dv0, dvf] = Cw2Impulse(n, x0, tof, varargin)
%
% ����˶�����(C-W����)
% 
% ����:
% n         ������ٶ�         (rad/s)
% x0        ��ʼ��λλ���ٶ�    (m, m/s)
% tof       ת��ʱ��           (s)
% xf        Ŀ����λλ���ٶ�    (m, m/s)    ��ȱʡ��Ĭ��Ϊ0
%
% ���:
% dv        �������ٶ�����     (m/s)
% dv0       ��һ���ٶ�����     (m/s)
% dvf       �ڶ����ٶ�����     (m/s)
%
% �ο���
% Orbital Mechanics for Engineering Students, 4th, Howard Curtis, p369-370

%% ����
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

%% ˫����
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
% ����
v0_ = phi_rv \ (rf - phi_rr * r0);
vf_ = phi_vr * r0 + phi_vv * v0_;
dv0 = v0_ - v0;
dvf = vf - vf_;
dv  = [norm(dv0) + norm(dvf) norm(dv0) norm(dvf)];
end