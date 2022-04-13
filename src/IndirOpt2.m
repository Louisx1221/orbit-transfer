function [sol] = IndirOpt2(x0, xf, sol0, DynEq)
% 间接法优化

t = sol0(:, 1);
sol0(:, 1) = [];

% solinit = bvpinit(t, @(x) SolInit(x, t, sol0));
% opts = bvpset('FJacobian',@jac,'RelTol',0.1,'AbsTol',0.1,'Stats','on');
% sol = bvp4c(DynEq, @(x) BoundCon(x, x0, xf), solinit);
% sol = bvp4c(DynEq, @(xa, xb) BoundCon(xa, xb, x0, xf), solinit);
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(DynEq,x0,[],[],[],[],[],[],@(x) CwCon(x, rv0, args))
end

%% 边界条件
function [c, ceq] = CwCon(x, rv0, args)
% x:    lambda, tf
% args: n, f, tspan

x0 = [rv0; x(1 : 6); zeros(3, 1)];

[~, x] = ode45(@(t, x) CwTpbvp(t, x, args), 0 : args.tspan : x(end), x0);

% 容许误差
tol = [1e1 1e1 1e1 1 1 1];
% 期望终端状态
rvf = zeros(1, 6);

ceq = abs(x(end, 1 : 6) - rvf);
c = [];
end