function [phi_lv] =  CwPhiLv(n, t)
% C-W协态变量状态转移矩阵v

s = sin(t);
c = cos(t);

phi_lv =[(4. * s - 3. * t) / n, -2. * (1. - c) / n, 0., 4. * c - 3., -2. * s, 0.;
         2. * (1. - c) / n, s / n, 0., 2. * s, c, 0.;
         0., 0., s / n, 0., 0., c];
end