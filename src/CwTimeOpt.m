function [dx] = CwTimeOpt(t, x, args)
% C-W交会时间最优控制方程
% x: [x, lambda, tf, u]

[A, B] = Cw(args.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

% 开关函数
% u = -lambda_v / norm(lambda_v) * args.f;
if 1 - norm(lambda_v) < 0
    u = -lambda_v / norm(lambda_v) * args.f;
else
    u = zeros(3, 1);
end

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
dx(7 : 12) = -A' * lambda;
if length(x) >= 15
    dx(13 : 15) = u - x(13 : 15);
    if length(x) == 16
        dx(16) = norm(u) - x(16);
    end
end
end