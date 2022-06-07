function [dx] = CwTimeOpt(t, x, ap)
% C-W交会时间最优控制方程
% 状态     x: [x, lambda, u]
% 辅助参数 ap: acc

[A, B] = Cw(ap.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

u = -ap.acc * lambda_v / norm(lambda_v);

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
dx(7 : 12) = -A' * lambda;
end