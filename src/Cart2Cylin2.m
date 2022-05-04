function [x, vx] = Cart2Cylin2(varargin)
% 笛卡尔坐标系转柱坐标系
% vq

if length(varargin) == 1
    r = varargin{1}(1 : 3);
    v = varargin{1}(4 : 6);
elseif length(varargin) == 2
    r = varargin{1};
    v = varargin{2};
else
    error('Inputs error!')
end

if size(r, 1) == 1
    r = r';
end
if size(v, 1) == 1
    v = v';
end

rx = r(1);
ry = r(2);
rz = r(3);
vx = v(1);
vy = v(2);
vz = v(3);

rho  = sqrt(rx * rx + ry * ry);
q    = atan2(ry, rx);
z    = rz;
cq   = cos(q);
sq   = sin(q);
vrho = vx * cq + vy * sq;
vq   = -vx * sq + vy * cq;

x     = r;
vx    = v;
x(1)  = rho;
x(2)  = q;
x(3)  = z;
vx(1) = vrho;
vx(2) = vq;
vx(3) = vz;

if length(varargin) == 1
    x = [x; vx];
end
end