function [dx] = CwFuel2Opt(t, x, args)
% C-W交会能量最优控制方程
% x: [x, lmabda, u]

[A, B] = Cw(args.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

u = -lambda_v;

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
dx(7 : 12) = -A' * lambda;
if length(x) == 9
    dx(13 : 15) = u - x(13 : 15);
end
end