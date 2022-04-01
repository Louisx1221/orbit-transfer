function [mat] = Vec2Mat(vec, n)
% 向量转矩阵

m = length(vec) / n;
mat = zeros(m, n);
for i = 1 : m
    mat(i, :) = vec((i - 1) * n + (1 : n));
end
end