function [r, v] = Coe2Eci(coe, varargin)
%
% 经典轨道根数转ECI坐标系位置速度
% 
% 输入：
% 经典轨道六根数 coe [6]
% coe(1) = semimajor axis          (m)
% coe(2) = orbital eccentricity    (-)     (0 <= eccentricity < 1)
% coe(3) = orbital inclination     (rad)   (0 <= inclination <= pi)
% coe(4) = RAAN                    (rad)   (0 <= RAAN <= 2 pi)
% coe(5) = argument of perigee     (rad)   (0 <= argument of perigee <= 2 pi)
% coe(6) = true anomaly            (rad)   (0 <= true anomaly <= 2 pi)
%
% 输出：
% ECI坐标系位置 r [3×1]            (m)
% ECI坐标系速度 v [3×1]            (m/s)  (可缺省)
%
% 参考：
% 卫星姿态动力学与控制 章仁为 1998.08 V1 p7-11

%% 地心引力常数
MU = 398600.4118;
if nargin == 2
    MU = varargin{1};  % for DU and TU
end 

%% 经典轨道根数
sma  = coe(1);
ecc  = coe(2);
inc  = coe(3);
raan = coe(4);
aop  = coe(5);
ta   = coe(6);

slr = sma * (1 - ecc * ecc);
rm = slr / (1 + ecc * cos(ta));

arglat = aop + ta;
sarglat = sin(arglat);
carglat = cos(arglat);

c4 = sqrt(MU / slr);
c5 = ecc * cos(aop) + carglat;
c6 = ecc * sin(aop) + sarglat;

sinc = sin(inc);
cinc = cos(inc);
sraan = sin(raan);
craan = cos(raan);

%% 位置矢量
r = [0 0 0]';
r(1) = rm * (craan * carglat - sraan * sarglat * cinc);
r(2) = rm * (sraan * carglat + craan * sarglat * cinc);
r(3) = rm * sarglat * sinc;

%% 速度矢量(可不输出)
if nargout == 2
    v = [0 0 0]';
    v(1) = - c4 * (c6 * craan + c5 * sraan * cinc);
    v(2) = - c4 * (c6 * sraan - c5 * craan * cinc);
    v(3) = c4 * c5 * sinc;
end
end