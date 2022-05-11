function [sol,fval,exitflag,output] = IndirOptEnergy(DynEq, s0, sf, tf, p)
% 间接法优化(能量最优)

x0 = 0.01 * ones(length(s0), 1);
options = optimset('TolX',1e-9,'TolFun',1e-9,'TolCon',1e-6,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',1000,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x,fval,exitflag,output] = fmincon(@(x) Cost(x, s0, tf, @(t, x) DynEq(t, x, p), p),x0,[],[],[],[],[],[],@(x) Con(x, s0, sf, tf, @(t, x) DynEq(t, x, p), p), options);

lambda = x;
% x0 = [s0; lambda; zeros(4, 1)];
x0 = [s0; lambda];
[t, x] = ode45(@(t, x) DynEq(t, x, p), 0 : p.tspan : tf, x0);
u = zeros(length(t), 4);
for i = 1 : length(t)
    u(i, 1 : 3) = -x(i, 10 : 12);
    u(i, 4) = norm(u(i, 1 : 3));
end
sol = [t, x, u];
end


%% 性能指标
function [J] = Cost(x, s0, tf, DynEq, p)
% x:    lambda, tf
% args: n, f, tspan

x0 = [s0; x(1 : 6); zeros(4, 1)];

[~, x] = ode45(DynEq, 0 : p.tspan : tf, x0);

J = sum(x(:, end).^2) * p.tspan;
end

%% 边界条件
function [c, ceq] = Con(x, s0, sf, tf, DynEq, p)
% x:    lambda, tf
% args: n, f, tspan

% x0 = [s0; x(1 : 6); zeros(4, 1)];
x0 = [s0; x(1 : 6)];
[~, x] = ode45(DynEq, 0 : p.tspan : tf, x0);

% 期望终端状态
ceq = abs(x(end, 1 : 6)' - sf);
c = [];
end