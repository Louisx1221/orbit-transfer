# C-W

$$
\left\{\begin{aligned}
	\dot\lambda_y &= -3n^2\lambda_v \\
	\dot\lambda_u &= -\lambda_x + 2n\lambda_v \\
	\dot\lambda_v &= -\lambda_y - 2n\lambda_u
\end{aligned}\right.
$$

$$
\begin{gathered}
	\ddot\lambda_v = -\dot\lambda_y - 2n\dot\lambda_u = -n^2\lambda_v + 2n\lambda_x \\
	\Rightarrow \lambda_v = C_1\cos nt + C_2\sin nt + \frac2n\lambda_x
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_y = -3C_1n^2\cos nt - 3C_2n^2\sin nt - 6n\lambda_x \\
	\Rightarrow \lambda_y = -3C_1n\sin nt + 3C_2n\cos nt - 6n\lambda_xt + C_3
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_u = 2C_1n\cos nt + 2C_2n\sin nt + 3\lambda_x \\
	\Rightarrow \lambda_u = 2C_1\sin nt - 2C_2\cos nt + 3\lambda_xt + C_4
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_v = -C_1n\sin nt + C_2n\cos nt - C_3 - 2nC_4 \\
	\Rightarrow C_3 + 2nC_4 = 0
\end{gathered}
$$

$$
\left\{\begin{aligned}
	\lambda_{y0} &= 3C_2n + C_3 \\
	\lambda_{u0} &= -2C_2 + C_4 \\
	\lambda_{v0} &= C_1 + \frac2n\lambda_{x0}
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	C_1 &= -\frac2n\lambda_{x0} + \lambda_{v0}\\
    C_2 &= -\frac1n\lambda_{y0} - 2\lambda_{u0} \\
    C_3 &= 4\lambda_{y0} + 6n\lambda_{u0} \\
    C_4 &= -\frac2n\lambda_{y0} - 3\lambda_{u0}
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	\lambda_{y} &= 6(\sin nt - nt)\lambda_{x0} + (4 - 3\cos nt)\lambda_{y0} + 6n(1 - \cos nt)\lambda_{u0} - 3n\sin nt\lambda_{v0} \\
	\lambda_{u} &= \frac{3nt - 4\sin nt}n\lambda_{x0} + \frac{2(\cos nt - 1)}n\lambda_{y0} + (4\cos nt - 3)\lambda_{u0} + 2\sin nt\lambda_{v0} \\
	\lambda_{v} &= \frac{2(1 - \cos nt)}n\lambda_{x0} - \frac{\sin nt}n\lambda_{y0} - 2\sin nt\lambda_{u0} + \cos nt\lambda_{v0}
\end{aligned}\right.
$$

$$
\boldsymbol\Phi_\lambda(t) = 
\left[\begin{array}{}
1 & 0 & 0 & 0 & 0 & 0 \\
6(\sin nt - nt) & 4 - 3\cos nt & 0 & 6n(1 - \cos nt) & -3n\sin nt & 0 \\
0 & 0 & \cos nt & 0 & 0 & n\sin nt\\
\frac{3nt - 4\sin nt}n & \frac{2(\cos nt - 1)}n & 0 & 4\cos nt - 3 & 2\sin nt & 0 \\
\frac{2(1 - \cos nt)}n & -\frac{\sin nt}n & 0 & -2\sin nt & \cos nt & 0 \\
0 & 0 & -\frac{\sin nt}n & 0 & 0 & \cos nt\\
\end{array}\right]
= \boldsymbol\Phi^{\mathrm T}(-t)
$$

