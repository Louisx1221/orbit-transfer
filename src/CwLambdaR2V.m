function [v] = CwLambdaR2V(r, n, tf)
% C-W拦截
% 协态变量满足 lambda_v(tf) == 0
% lambda_v(t0) = CwLambdaR2V(lambda_r(t0))

nt = n * tf;
s = sin(nt);
c = cos(nt);
d = n * (4 - 3 * c);

v = r;
v(1) = (s * r(1) + (6 * nt * s + 14 * (c - 1)) * r(2)) / d;
v(2) = (2 * (1 - c) * r(1) + (4 * s - 3 * nt * c) * r(2)) / d;
v(3) = s / c / n * r(3);
end