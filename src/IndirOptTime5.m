function [sol,fval,exitflag,output] = IndirOptTime5(DynEq, s0, sf, tf, p)
% 拦截(rf == 0, vf ~= 0)
% 间接法优化(时间最优)
% 遗传

lb = [-1 * ones(length(s0) / 2, 1); 0.5 * tf];
ub = [1 * ones(length(s0) / 2, 1); 0.7 * tf];
% lb=[];
% ub=[];
dim = length(s0) / 2 + 1;
options = optimoptions('ga', ...
    'PopulationSize', 20, ...
    'Generations', 10, ...
    'Display','iter','PlotFcn',@gaplotbestf);
[x,fval,exitflag,output] = ga(@(x) Cost(x, s0, sf, DynEq, p),dim,[],[],[],[],lb,ub,@(x) Con(x, s0, sf, DynEq, p), options);

tf = x(end);
lr = x(1 : 3);
lv = CwLambdaR2V(lr, p.n, tf);

x0 = [s0; [lr lv]'; zeros(4, 1)];

[t, x] = ode45(DynEq, 0 : p.tspan : tf, x0);
sol = [t, x];
end


%% 性能指标
function [J] = Cost(x, s0, sf, DynEq, p)

tf = x(end);
lr = x(1 : 3);
lv = CwLambdaR2V(lr, p.n, tf);

x0 = [s0; [lr lv]'; zeros(4, 1)];
[~, x] = ode45(DynEq, 0 : p.tspan : tf, x0);

% 指标
J = tf;

% 罚函数
J = J + norm(x(end, 1 : 3)' - sf(1 : 3));
end

%% 边界条件
function [c, ceq] = Con(x, s0, sf, DynEq, p)
% x:    lambda, tf
% args: n, f, tspan

tf = x(end);
lr = x(1 : 3);
lv = CwLambdaR2V(lr, p.n, tf);

x0 = [s0; [lr lv]'; zeros(4, 1)];

[~, x] = ode45(DynEq, 0 : p.tspan : tf, x0);
% dxf = DynEq(0, x(end, :)');

% 期望终端状态
ceq = x(end, 1 : 6)' - sf;
% ceq(1 : 3) = ceq(1 : 3) * 1e-2;
ceq = ceq(1 : 3);
% ceq = [ceq; 1 + x(end, 7 : 12) * dxf(1 : 6)];
c = [];
end