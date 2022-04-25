function [sol] = IndirOptTimeSs2(DynEq, s0, sf, sol0, p)
% 间接法优化(时间最优)

if size(s0, 1) == 1
    s0 = s0';
end
if size(sf, 1) == 1
    sf = sf';
end

t = sol0(:, 1);
sol0(:, 1) = [];

solinit = bvpinit(t, @(x) SolInit(x, t, sol0));
% opts = bvpset('FJacobian',@fjac,'RelTol',0.1,'AbsTol',0.1,'Stats','on');
opts = [];
% sol = bvp4c(DynEq, @(x) BoundCon(x, x0, xf), solinit);
sol = bvp4c(DynEq, @(xa, xb) BoundCon(DynEq, xa, xb, s0, sf, p), solinit, opts);

end

%% 生成初始值
function sol = SolInit(x, t, sol0)
    sol = interp1(t, sol0, x);
end

%% 边界条件
function [ceq] = BoundCon(DynEq, xa, xb, x0, xf, p)

ceq = zeros(9, 1);
ceq(1 : 4) = xa(1 : 4) - x0;
ceq(5 : 8) = xb(1 : 4) - xf;
dxb = DynEq(1, xb);
ceq(9) = 1 + xb(5 : 8)' * dxb(1 : 4);
ceq(9) = 0;
end