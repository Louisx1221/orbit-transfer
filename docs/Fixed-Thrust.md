# Fixed-Thrust

$$
\left\{\begin{aligned}
	a_x &= fu_x \\
	a_y &= fu_y \\
	a_z &= fu_z
\end{aligned}\right.
$$

$$
\min J = \int_{t_0}^{t_f}f\mathrm{d}t
$$

$$
\begin{aligned}
	H &= \lambda_x v_x + \lambda_y v_y + \lambda_z v_z + \lambda_u (2nv_y + 3n^2x + a_x) + \lambda_v (-2nv_x + a_y) + \lambda_z (-n^2z + a_z) + f \\
	&= \lambda_x v_x + \lambda_y v_y + \lambda_z v_z + \lambda_u (2nv_y + 3n^2x) - 2 \lambda_v nv_x - \lambda_w n^2z + (1 + \lambda_uu_x + \lambda_vu_y + \lambda_wu_z)f
\end{aligned}
$$


$$
\frac{\partial H}{\partial \boldsymbol{u}} = 0 \\
\Rightarrow
\left\{\begin{aligned}
	u_x &= -\frac{\lambda_u}{\sqrt{\lambda_u^2 + \lambda_v^2 + \lambda_w^2}} \\
	u_y &= -\frac{\lambda_v}{\sqrt{\lambda_u^2 + \lambda_v^2 + \lambda_w^2}} \\
	u_z &= -\frac{\lambda_w}{\sqrt{\lambda_u^2 + \lambda_v^2 + \lambda_w^2}}
\end{aligned}\right.
$$

$$
\dot{\boldsymbol{\lambda}} = -\frac{\partial H}{\boldsymbol{\partial x}} \Leftrightarrow
\left\{\begin{aligned}
	\dot\lambda_x &= -3n^2\lambda_u \\
	\dot\lambda_y &= 0 \\
	\dot\lambda_z &= n^2\lambda_w \\
	\dot\lambda_u &= -\lambda_x + 2n\lambda_v \\
	\dot\lambda_v &= -\lambda_y - 2n\lambda_u \\
	\dot\lambda_w &= -\lambda_z
\end{aligned}\right.
$$

$$
\boldsymbol{\lambda} = \Phi_{\lambda}(t,t_0) \boldsymbol{\lambda}_0 = \Phi^{\mathrm{T}}(t_0, t) \boldsymbol{\lambda}_0
$$

