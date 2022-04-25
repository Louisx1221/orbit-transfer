function [x, dx] = Cartesian2Cylindrical(r, v)
rx = r(1);
ry = r(2);
rz = r(3);
vx = v(1);
vy = v(2);
vz = v(3);

rho = sqrt(rx * rx + ry * ry);
theta = atan2(ry, rx);
z = rz;
drho = vx * cos(theta) + vy * sin(theta);
dtheta = (-vx * sin(theta) + vy * cos(theta)) / rho;
dz = vz;

x = r;
dx = v;
x(1) = rho;
x(2) = theta;
x(3) = z;
dx(1) = drho;
dx(2) = dtheta;
dx(3) = dz;
end