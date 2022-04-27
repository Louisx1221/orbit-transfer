function [x, dx] = Cart2Cylin(varargin)
% 笛卡尔坐标系转柱坐标系

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
drho = vx * cq + vy * sq;
dq   = (-vx * sq + vy * cq) / rho;
dz   = vz;

x     = r;
dx    = v;
x(1)  = rho;
x(2)  = q;
x(3)  = z;
dx(1) = drho;
dx(2) = dq;
dx(3) = dz;

if length(varargin) == 1
    x = [x; dx];
end
end