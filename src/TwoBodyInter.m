function [sp, se, lambda, tf] = TwoBodyInter(xp, xe, tf, ap, varargin)
% 二体拦截(时间最优)

if isempty(varargin)
    x0 = [0.01 * ones(length(s0), 1); 0.8 * tf];
else
    if length(varargin{1}) == 1
        x0 = [0.01 * ones(length(s0), 1); varargin{1}];
    else
        x0 = varargin{1};
    end
end

if ~isfield(ap, 'tspan')
    ap.tspan = 1e-4 * tf;
end

lb = [-1e2 * ones(6, 1); 0.8 * tf];
ub = [1e2 * ones(6, 1); 1.2 * tf];

options = optimset('TolX',1e-6,'TolFun',1e-6,'TolCon',1e-3,...
                    'Algorithm','interior-point',...
                    'MaxFunEvals',10000000,'MaxIter',1000,...
                    'Display','iter','largescale','on','PlotFcn','optimplotfvalconstr');
[x] = fmincon(@(x) Cost(x),x0,[],[],[],[],lb,ub,@(x) Con(x, xp, xe, ap), options);

tf = x(end);
lambda = x(1 : 6);

xp = [xp; lambda];
[t, s] = ode45(@(t, x) TwoBodyTimeOpt(t, x, ap), 0 : ap.tspan : tf, xp);
u = zeros(length(t), 3);
for i = 1 : length(t)
    u(i, 1 : 3) = -s(i, 10 : 12) / norm(s(i, 10 : 12));
end
sp = [t, s, u];

[t, s] = ode45(@(t, x) TwoBodyEq(t, x, zeros(3, 1), ap), 0 : ap.tspan : tf, xe);
se = [t, s];
end

%% 性能指标
function [J] = Cost(x)

J = x(end);
end

%% 边界条件
function [c, ceq] = Con(x, xp, xe, ap)
% x:  lambda, tf
% ap: acc, tspan

tf = x(end);
xp = [xp; x(1 : 6)];

[~, sp] = ode45(@(t, x) TwoBodyTimeOpt(t, x, ap), 0 : ap.tspan : tf, xp);

% 期望终端状态
[~, se] = ode45(@(t, x) TwoBodyEq(t, x, zeros(3, 1), ap), 0 : ap.tspan : tf, xe);

ceq = sp(end, 1 : 3)' - se(end, 1 : 3)';
ceq = [ceq; sp(end, 10 : 12)'];
ceq = [ceq; 1 + sp(end, 7 : 9) * sp(end, 4 : 6)'];
c = [];
end