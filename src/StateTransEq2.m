function [dPhiPsi] = StateTransEq2(t, PhiPsi, FuncAB)
% (控制)状态转移矩阵方程
% Psi = int(Phi * B)
% dPsi = Phi * B
% Phi = exp(A)
% dPhi = Phi * A


n = sqrt(length(Phi) + 1/4) - 1/2;
PhiM = zeros(n);
% 先列后行
for i = 1 : n
    PhiM(:, i) = PhiPsi((i - 1) * n + (1 : n));
end
Psi = PhiPsi(n * n + (1 : n));


[A, ~] = FuncAB(tf - t);

[~, B] = FuncAB(t);
dPhiM = PhiM * A;
dPhi = Phi;
for i = 1 : n
    dPhi((i - 1) * n + (1 : n)) = dPhiM(:, i);
end
dPsi = Psi * B;
end