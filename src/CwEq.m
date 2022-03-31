function [dx] = CwEq(t, x, u, args)
% C-W状态方程

if size(x, 1) == 1
    x = x';
end
if size(u, 1) == 1
    u = u';
end

[A, B] = Cw(args.n);

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * u;
if length(x) == 9
    dx(7 : 9) = u - x(7 : 9);
end
end