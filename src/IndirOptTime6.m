function [sol,fval,exitflag,output] = IndirOptTime6(DynEq, s0, sf, tf, p, varargin)
% 拦截(rf == 0, vf ~= 0)
% 间接法优化(时间最优)

if isempty(varargin)
    x0 = [0.01 * ones(length(s0), 1); 0.6 * tf];
else
    if length(varargin{1}) == 1
        x0 = [0.01 * ones(length(s0), 1); varargin{1}];
    elseif length(varargin{1}) == 4
        x0 = varargin{1};
    elseif length(varargin{1}) == 7
        x0 = [varargin{1}(1 : 3); varargin{1}(end)];
    end
end

lb = [-1e5 * ones(length(s0) / 2, 1); 0.5 * tf];
ub = [1e5 * ones(length(s0) / 2, 1); 0.7 * tf];
% lb=[];
% ub=[];
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-2,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',500,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x,fval,exitflag,output] = fmincon(@(x) Cost(x),x0,[],[],[],[],lb,ub,@(x) Con(x, s0, sf, DynEq, p), options);

tf = x(end);
lr = x(1 : 3);
lv = CwLambdaR2V(lr, p.n, tf);

x0 = [s0; lr; lv];

[t, x] = ode45(DynEq, 0 : p.tspan : tf, x0);
sol = [t, x];
end


%% 性能指标
function [J] = Cost(x)

J = x(end);
end

%% 边界条件
function [c, ceq] = Con(x, s0, sf, DynEq, p)
% x:    lambda, tf
% args: n, f, tspan

tf = x(end);
lr = x(1 : 3);
lv = CwLambdaR2V(lr, p.n, tf);

x0 = [s0; lr; lv];

[~, x] = ode45(DynEq, 0 : p.tspan : tf, x0);
% dxf = DynEq(0, x(end, :)');

% 期望终端状态
ceq = x(end, 1 : 6)' - sf;
% ceq(1 : 3) = ceq(1 : 3) * 1e-2;
ceq = ceq(1 : 3);
% ceq = [ceq; 1 + x(end, 7 : 12) * dxf(1 : 6)];
c = [];
end