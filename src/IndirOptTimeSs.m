function [sol,fval,exitflag,output] = IndirOptTimeSs(DynEq, s0, sf, tf, p)
% 间接法优化(时间最优)

if size(s0, 1) == 1
    s0 = s0';
end
if size(sf, 1) == 1
    sf = sf';
end

x0 = [0.01 * ones(length(s0), 1); 0.9 * tf];
lb = [-1e4 * ones(length(s0), 1); 0.5 * tf];
ub = [1e4 * ones(length(s0), 1); 1.1 * tf];
% lb=[];
% ub=[];
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',200,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x,fval,exitflag,output] = fmincon(@(x) Cost(x),x0,[],[],[],[],lb,ub,@(x) Con(x, s0, sf, DynEq, p), options);

tf = x(end);
x0 = [s0; x(1 : 4); zeros(1, 1)];
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
x0 = [s0; x(1 : 4)];

[~, x] = ode45(DynEq, 0 : p.tspan : tf, x0);
[~, s] = ode45(@(t, x) SolarSailEq(t, x, 0, p), 0 : p.tspan : tf, sf);
sf = s(end, 1 : 4)';
dxf = DynEq(0, x(end, :)');

% 期望终端状态
ceq = x(end, 1 : 4)' - sf;
% ceq(1 : 3) = ceq(1 : 3) * 1e-2;
% ceq(3 : 4) = [];
% ceq = [ceq; 1 + x(end, 5 : 8) * dxf(1 : 4)];
c = [];
end