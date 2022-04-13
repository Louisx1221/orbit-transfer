function [J] = CostEnergy(sol, tf)
% 燃料最优价值函数

N = size(sol, 1);
J = sum(sol(:, end) .^2 ) * tf / N / 2;
end