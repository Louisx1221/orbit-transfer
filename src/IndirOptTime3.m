function [sol,fval,exitflag,output] = IndirOptTime3(DynEq, s0, sf, tf, p)
% 间接法优化(时间最优)

x0 = [0.1 * ones(length(s0), 1); 0.9 * tf];
% x0 = [0.175367398837258,	0.135664758657441,	0.0386643980955303,	-40.2782600326209,	177.640845997421,	2.29760725130391, 800]';
lb = [-1 * ones(length(s0), 1); p.tspan];
ub = [1 * ones(length(s0), 1); 1.1 * tf];
% lb=[];
% ub=[];
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',200,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x,fval,exitflag,output] = fmincon(@(x) Cost(x),x0,[],[],[],[],lb,ub,@(x) Con(x, s0, sf, DynEq, p), options);

tf = x(end);
x0 = [s0; x(1 : 7); zeros(4, 1)];
[t, x] = ode45(DynEq, (0 : p.tspan : tf) / tf, x0);
t = t * x(end, 13);
x(:, 13) = [];
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
x0 = [s0; x(1 : 7); zeros(4, 1)];

[~, x] = ode45(DynEq, (0 : p.tspan : tf) / tf, x0);
dxf = DynEq(0, x(end, :)');

% 期望终端状态
ceq = x(end, 1 : 6)' - sf;
% ceq(1 : 3) = ceq(1 : 3) * 1e-1;
% ceq = [ceq; 1 + x(end, 7 : 12) * dxf(1 : 6)];
ceq = [ceq; 1 + x(end, 7 : 12) * dxf(1 : 6) / tf];
c = [];
end