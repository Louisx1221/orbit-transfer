function [dx] = CwPhiEq(t, x, n, tf)
% C-WЭ̬����״̬����

Phi = CwPhi(n, tf - t);
[~, b] = Cw(n);

Phi_l = CwPhi(n, -t)';
phi_dot = Phi * b * Phi_l(4 : 6, :);

dx = x;
for i = 1 : 6
    dx(6 * (i - 1) + (1 : 6)) = phi_dot(:, i);
end
end