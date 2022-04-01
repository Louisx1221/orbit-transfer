function [J] = CostFuel(sol, tf)
% 燃料最优价值函数

N = size(sol, 1);
J = sum(sol(:, end)) * tf / N;
end