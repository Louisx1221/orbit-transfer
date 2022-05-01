function [t, x] = CwIndirOpt(x0, n, tf, varargin)
% 连续推力C-W交会
% 燃料最优 J = \min \int \sum a_i ^ 2 \mathrm{d} t / 2

flag = 1;
if isempty(varargin)
    step = 1;
else
    step = varargin{1};
    if length(varargin) == 2
        if strcmp(varargin{2}, 'Riccati')
           flag = 2;
        end
    end
end

% 协态变量初始值
if flag == 1
    Psi0 = zeros(6);
    [~, Psi] = ode45(@(t, x) CwPsiEq(t, x, n, tf), 0 : step : tf, Psi0);

    Psif = zeros(6);
    for i = 1 : 6
        Psif(:, i) = Psi(end, 6 * (i - 1) + (1 : 6))';
    end
    Phif = CwPhi(n, tf);
    lambda0 = -Psif \ (Phif * x0) ;
    % xf = [0., 0., 0., 0., 0., 0.]';
    % lambda0 = -Psif \ (Phif * x0 - xf);
else
    P = CwRiccati(n, tf, step);
    lambda0 = P * x0;
end

x0 = [x0; zeros(3, 1)];
[t, x] = ode45(@(t, x) CwOptEq(t, x, n, lambda0), 0 : step : tf, x0);
end

%% C-W协态变量状态方程
function [dx] = CwPsiEq(t, x, n, tf)

Phi = CwPhi(n, tf - t);
[~, B] = Cw(n);

Phi_l = CwPhi(n, -t)';
Tau = -B' * Phi_l;
dPsi = Phi * B * Tau;

dx = x;
for i = 1 : 6
    dx(6 * (i - 1) + (1 : 6)) = dPsi(:, i);
end
end

%% C-W方程黎卡提方程
function [P] = CwRiccati(n, tf, step)
% \dot P = -A' P - P A - P Q P
% Q = B R' B
% S = diag([sr, sr, sr, sv, sv, sv])
% R = diag([r r r])

S = diag([1 * ones(1, 3), 1 * ones(1, 3)]);
[~, x] = ode45(@(t, x) CwRiccatiEq(t, x, n), 0 : step : tf, S);
x = x(end, :);

P = zeros(6);
for i = 1 : 6
    P(:, i) = x(6 * (i - 1) + (1 : 6));
end
end

%% C-W交会协态变量黎卡提方程
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

%% C-W交会最优控制方程
function [dx] = CwOptEq(t, x, n, lambda0)

[A, B] = Cw(n);

Phi = CwPhi(n, -t).';
tau = -B' * Phi * lambda0;

dx = x;
dx(1 : 6) = A * x(1 : 6) + B * tau;
% dx = A * x;

if length(x) == 9
    dx(7 : 9) = tau - x(7 : 9);
end
end