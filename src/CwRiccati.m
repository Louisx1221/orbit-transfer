function [P] = CwRiccati(n, tf, step)
% C-W方程黎卡提方程
% \dot P = -A' P - P A - P Q P
% Q = B R' B
% S = diag([sr, sr, sr, sv, sv, sv])
% R = diag([r r r])

S = diag([1 * ones(1, 3), 1e-4 * ones(1, 3)]);
[~, x] = ode45(@(t, x) CwRiccatiEq(t, x, n), 0 : step : tf, S);
x = x(end, :);

P = zeros(6);
for i = 1 : 6
    P(:, i) = x(6 * (i - 1) + (1 : 6));
end
end

function [dx] = CwRiccatiEq(~, x, n)

P = zeros(6);
for i = 1 : 6
    P(:, i) = x(6 * (i - 1) + (1 : 6));
end

[A, B] = Cw(n);
R = 1 * eye(3);
Q = B * R' * B';
dP = A' * P + P * A - P * Q * P;

dx = x;
for i = 1 : 6
    dx(6 * (i - 1) + (1 : 6)) = dP(:, i);
end
end