function [dphi] = StateTransEq(t, phi_, FuncState)
% 状态转移矩阵方程
% Phi = exp(A)
% dPhi = Phi * A

n = sqrt(length(phi_));
phi_ = reshape(phi_, [n, n]);
A = FuncState(t);
dphi = A * phi_;
dphi = reshape(dphi, [n^2, 1]);
end