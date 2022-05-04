function [dPhi] = StateTransEq(t, Phi, FuncState)
% 状态转移矩阵方程
% Phi = exp(A)
% dPhi = Phi * A

n = sqrt(length(Phi));
PhiM = zeros(n);
% 先列后行
for i = 1 : n
    PhiM(:, i) = Phi((i - 1) * n + (1 : n));
end
A = FuncState(t);
dPhiM = PhiM * A;
dPhi = Phi;
for i = 1 : n
    dPhi((i - 1) * n + (1 : n)) = dPhiM(:, i);
end
end