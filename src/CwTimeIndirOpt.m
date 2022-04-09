function [sol] = CwTimeIndirOpt(x0, xf, sol0, args)
% C-W交会时间最优间接法优化

t = sol0(:, 1);
sol0(:, 1) = [];

solinit = bvpinit(t, @(x) SolInit(x, t, sol0));
% opts = bvpset('FJacobian',@jac,'RelTol',0.1,'AbsTol',0.1,'Stats','on');
% sol = bvp4c(DynEq, @(x) BoundCon(x, x0, xf), solinit);
sol = bvp4c(@(t, x) CwTimeOpt(t, x, args), @(xa, xb) BoundCon(xa, xb, x0, xf, args), solinit);
end

%% 边界条件
function [ceq] = BoundCon(xa, xb, x0, xf, args)

ceq = zeros(13, 1);
ceq(1 : 6) = xa(1 : 6) - x0;
ceq(7 : 12) = xb(1 : 6) - xf;
dxb = CwTimeOpt(1, xb, args);
ceq(13) = 1 + xb(7 : 12)' * dxb(1 : 6);
end

%% 生成初始值
function sol = SolInit(x, t, sol0)
    sol = interp1(t, sol0, x);
end