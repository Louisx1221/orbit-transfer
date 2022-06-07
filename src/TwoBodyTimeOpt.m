function [dx] = TwoBodyTimeOpt(t, x, ap)
%% 二体模型时间最优控制方程
% [x, lambda]

r  = x(1 : 3);
v  = x(4 : 6);
lr = x(7 : 9);
lv = x(10 : 12);
r_ = norm(r);
r3 = r_ * r_ * r_;
r5 = r3 * r_ * r_;

u = -lv / norm(lv);
u = ap.acc * u;

dx = x;
% x
dx(1 : 3) = v;
dx(4 : 6) = -ap.MU / r3 * r + u;
% lambda
dx(7) = 3 * ap.MU / r5 * r(1) * r(1) - ap.MU / r3;
dx(8) = 3 * ap.MU / r5 * r(2) * r(2) - ap.MU / r3;
dx(9) = 3 * ap.MU / r5 * r(3) * r(3) - ap.MU / r3;
dx(10 : 12) = -lr;
end