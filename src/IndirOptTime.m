function [sol,lambda, fval,exitflag,output] = IndirOptTime(DynEq, s0, sf, tf, ap, varargin)
% 间接法优化(时间最优)

if isempty(varargin)
    x0 = [0.01 * ones(length(s0), 1); 0.8 * tf];
else
    if length(varargin{1}) == 1
        x0 = [0.01 * ones(length(s0), 1); varargin{1}];
    else
        x0 = varargin{1};
    end
end

lb = [-1e4 * ones(length(s0), 1); 0.5 * tf];
ub = [1e4 * ones(length(s0), 1); 1.0 * tf];
% lb=[];
% ub=[];
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-5,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',1000,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x,fval,exitflag,output] = fmincon(@(x) Cost(x),x0,[],[],[],[],lb,ub,@(x) Con(x, s0, sf, @(t, x) DynEq(t, x, ap), ap), options);

tf = x(end);
lambda = x(1 : 6);

x0 = [s0; lambda];
[t, x] = ode45(@(t, x) DynEq(t, x, ap), 0 : ap.tspan : tf, x0);
alpha = zeros(length(t), 3);
for i = 1 : length(t)
    alpha(i, 1 : 3) = -x(i, 10 : 12) / norm(x(i, 10 : 12));
end
sol = [t, x, alpha];

end

%% 性能指标
function [J] = Cost(x)

J = x(end);
end

%% 边界条件
function [c, ceq] = Con(x, s0, sf, DynEq, ap)
% x:    lambda, tf
% args: n, f, tspan

tf = x(end);
x0 = [s0; x(1 : 6)];

[~, x] = ode45(DynEq, 0 : ap.tspan : tf, x0);
% dxf = DynEq(0, x(end, :)');

% 期望终端状态
[~, sf] = ode45(DynEq, 0 : ap.tspan : tf, sf);
sf = sf(end, :)';

ceq = x(end, 1 : 6)' - sf;
% ceq(1 : 3) = ceq(1 : 3) * 1e-2;
% ceq = ceq(1 : 3);
% ceq = [ceq; x(end, 10 : 12)'];
% ceq = [ceq; 1 + x(end, 7 : 12) * dxf(1 : 6)];
c = [];
end