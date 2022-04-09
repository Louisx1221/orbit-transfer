function [dx] = CwTimeOpt(t, x, args)
% C-W交会时间最优控制方程
% x: [x, lmabda, tf, u]

[A, B] = Cw(args.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

u = -lambda_v / norm(lambda_v) * args.n;

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
dx(7 : 12) = -A' * lambda;
dx(13) = 0;
dx = dx * x(13);
if length(x) >= 15
    dx(13 : 15) = u - x(13 : 15);
    if length(x) == 16
        dx(16) = norm(dx(13 : 15));
    end
end
end