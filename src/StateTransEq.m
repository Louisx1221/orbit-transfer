function [dPhi] = StateTransEq(t, Phi, FuncState)
% 状态转移矩阵方程
% Phi = exp(A)
% dPhi = Phi * A

n = sqrt(length(Phi));
Phi = reshape(Phi, [n, n]);
A = FuncState(t);
dPhi = Phi * A;
dPhi = reshape(dPhi, [n^2, 1]);
end