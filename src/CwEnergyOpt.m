function [dx] = CwEnergyOpt(t, x, p)
% C-W交会能量最优控制方程
% x: [x, lambda, u]

[A, B] = Cw(p.n);

lambda = x(7 : 12);

lambda_v = B' * lambda;

u = -lambda_v;

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