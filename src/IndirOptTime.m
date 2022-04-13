function [sol,fval,exitflag,output] = IndirOptTime(DynEq, s0, sf, tf, p)
% 间接法优化(能量最优)

x0 = [0.1 * ones(length(s0), 1); tf];
lb = [-ones(length(s0), 1); 0.4 * tf];
ub = [ones(length(s0), 1); 1.1 * tf];
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',100,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x,fval,exitflag,output] = fmincon(@(x) Cost(x),x0,[],[],[],[],lb,ub,@(x) Con(x, s0, sf, DynEq, p), options);

tf = x(end);
x0 = [s0; x(1 : 6); zeros(4, 1)];
[t, x] = ode45(DynEq, 0 : p.tspan : tf, x0);
sol = [t, x];
end


%% 性能指标
function [J] = Cost(x)

J = x(end);
end

%% 边界条件
function [c, ceq] = Con(x, s0, sf, DynEq, args)
% x:    lambda, tf
% args: n, f, tspan

tf = x(end);
x0 = [s0; x(1 : 6); zeros(4, 1)];

[~, x] = ode45(DynEq, 0 : args.tspan : tf, x0);
dxf = DynEq(0, x(end, :)');

% 期望终端状态
ceq = abs(x(end, 1 : 6)' - sf);
ceq(1 : 3) = ceq(1 : 3) * 1e-1;
ceq = [ceq; 1 + x(end, 7 : 12) * dxf(1 : 6)];
c = [];
end