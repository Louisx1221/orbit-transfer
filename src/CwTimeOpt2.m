function [dx] = CwTimeOpt2(t, x, p)
% C-W交会时间最优控制方程
% x: [x, lambda, tf, u]

[A, B] = Cw(p.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

u = -p.f * lambda_v / norm(lambda_v);

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
dx(7 : 12) = -A' * lambda;
dx(13) = 0;
if length(x) >= 16
    dx(14 : 16) = u - x(14 : 16);
    if length(x) == 17
        dx(17) = norm(u) - x(17);
    end
end
dx = x(13) * dx;
end