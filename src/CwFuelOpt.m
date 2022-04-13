function [dx] = CwFuelOpt(t, x, epsilon, args)
% C-W交会燃料最优控制方程
% x: [x, lambda, u]

[A, B] = Cw(args.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

% 开关函数
rho = 1 - args.f * norm(lambda_v);
if rho > epsilon
    u = 0;
elseif rho < -epsilon
    u = 1;
else
    u = 1 / 2 - rho / 2 / epsilon;
end
u = u * args.f * lambda_v / norm(lambda_v);

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