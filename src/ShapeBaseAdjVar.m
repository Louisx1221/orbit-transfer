function [lambda] = ShapeBaseAdjVar(t, cr, cq, cz, x0, xf, p, varargin)
% 柱坐标系交会(燃料最优)
% 形状法找协态变量初值

% 协态变量初值的初值
if isempty(varargin)
    lambda0 = 1e-2 * ones(6, 1);
else
    lambda0 = varargin{1};
end

% 动力学方程句柄
FuncState = @(t) HmTSysCtrlMat(t, cr, cq, cz, x0, xf, p);

%% 状态转移矩阵
phi0 = eye(12);
[~, phiv] = ode45(@(t, x) StateTransEq(t, x, FuncState), t, phi0);
phi_ = reshape(phiv(end, :), [12, 12]);
Phi12 = phi_(1 : 6, 7 : 12);


%% 协态变量初值
delta_x0 = zeros(6, 1);
[~, delta_x_lambda] = ode45(@(t, x) StateTransEq2(t, x, FuncState), t, [delta_x0; lambda0]);
% [~, x_sc] = ode45(@(t, x) CylinEnergyEq(t, x, p), t, [x0; lambda0]);
% 打靶函数
psi_ = delta_x_lambda(end, 1 : 6)';
% Psi = delta_x_lambda(end, 1 : 6)' + xf - x_sc(end, 1 : 6)';

% 牛顿迭代   
lambda = lambda0 - Phi12 \ psi_;
end