function [vec, m, n] = Mat2Vec(mat)
% 矩阵转向量

[m, n] = size(mat);
vec = zeros(1, m * n);
for i = 1 : m
    vec((i - 1) * n + (1 : n)) = mat(i, :);
end