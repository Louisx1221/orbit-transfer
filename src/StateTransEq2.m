function [dx] = StateTransEq2(t, x, FuncState)
% (控制)状态转移矩阵方程
% delta_x, lambda

[A, B] = FuncState(t);

dx = A * x - B;
end