function [dx] = CwEnergyCost(x, p)
% C-W交会能量最优性能指标
% x: [x, lmabda, u]

x0 = [p.x0; x(1 : 6); zeros(4, 1)];
p.lambda = x;
[t, x] = ode45(@(t, x) CwEnergyOpt(t, x, p), 0 : p.tspan : p.tf, x0);

J = 0;
for i = 1 : length(t)
    J = J + norm(x(i, 7 : 9));
end
end