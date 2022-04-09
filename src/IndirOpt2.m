function [sol] = IndirOpt2(x0, xf, sol0, DynEq)
% 间接法优化

t = sol0(:, 1);
sol0(:, 1) = [];

solinit = bvpinit(t, @(x) SolInit(x, t, sol0));
% opts = bvpset('FJacobian',@jac,'RelTol',0.1,'AbsTol',0.1,'Stats','on');
% sol = bvp4c(DynEq, @(x) BoundCon(x, x0, xf), solinit);
% sol = bvp4c(DynEq, @(xa, xb) BoundCon(xa, xb, x0, xf), solinit);
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(DynEq,x0,[],[],[],[],[],[],, options)
end

%% 边界条件
function [ceq] = BoundCon(xa, xb, x0, xf)

ceq = zeros(12, 1);
ceq(1 : 6) = xa(1 : 6) - x0;
ceq(7 : 12) = xb(1 : 6) - xf;

end

%% 生成初始值
function sol = SolInit(x, t, sol0)
    sol = interp1(t, sol0, x);
end