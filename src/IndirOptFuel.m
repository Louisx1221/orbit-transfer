function [sol,fval,exitflag,output] = IndirOptFuel(DynEq, s0, sf, tf, p)
% 间接法优化(燃料最优)

x0 = 0.01 * ones(length(s0), 1);
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',1000,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
for epsilon = 1 - (0 : 0.2 : 1)
    [x,fval,exitflag,output] = fmincon(@(x) Cost(x, s0, tf, @(t, x) DynEq(t, x, epsilon, p), p),x0,[],[],[],[],[],[],@(x) Con(x, s0, sf, tf, @(t, x) DynEq(t, x, epsilon, p), p), options);
    x0 = x;
end

x0 = [s0; x(1 : 6); zeros(4, 1)];
[t, x] = ode45(@(t, x) DynEq(t, x, epsilon, p), 0 : p.tspan : tf, x0);
sol = [t, x];
end


%% 性能指标
function [J] = Cost(x, s0, tf, DynEq, args)
% x:    lambda, tf
% args: n, f, tspan

x0 = [s0; x(1 : 6); zeros(4, 1)];

[~, x] = ode45(DynEq, 0 : args.tspan : tf, x0);

J = sum(x(:, end).^2) * args.tspan;
end

%% 边界条件
function [c, ceq] = Con(x, s0, sf, tf, DynEq, args)
% x:    lambda, tf
% args: n, f, tspan

x0 = [s0; x(1 : 6); zeros(4, 1)];

[~, x] = ode45(DynEq, 0 : args.tspan : tf, x0);

% 期望终端状态
ceq = x(end, 1 : 6)' - sf;
c = [];
end