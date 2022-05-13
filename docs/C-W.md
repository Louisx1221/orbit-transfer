# C-W



## Y

$$
\dot\lambda_y = 0 \\
\Rightarrow \lambda_y = \lambda_{y0}
$$

## ZW

$$
\left\{\begin{aligned}
	\dot\lambda_z &= n^2\lambda_w \\
	\dot\lambda_w &= -\lambda_z
\end{aligned}\right.
$$

$$
\begin{gathered}
	\ddot\lambda_w = -\dot\lambda_z = -n^2\lambda_w \\
	\Rightarrow \lambda_w = C_1\sin nt + C_2\cos nt
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_z = C_1n^2\sin nt + C_2n^2\cos nt \\
	\Rightarrow \lambda_z = -C_1n\cos nt + C_2n\sin nt + C_3
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_w = C_1n\cos nt - C_2n\sin nt - C_3\\
	\Rightarrow C_3 = 0
\end{gathered}
$$

$$
\left\{\begin{aligned}
	\lambda_{z0} &= -nC_1 \\
	\lambda_{w0} &= C_2
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	C_1 &= -\frac1n\lambda_{z0}\\
    C_2 &= \lambda_{w0}
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	\lambda_{z} &= \cos nt\lambda_{z0} + n\sin nt\lambda_{w0} \\
	\lambda_{w} &= -\frac{\sin nt}n\lambda_{z0} + \cos nt\lambda_{w0}
\end{aligned}\right.
$$

## XUV

$$
\left\{\begin{aligned}
	\dot\lambda_x &= -3n^2\lambda_u \\
	\dot\lambda_u &= -\lambda_x + 2n\lambda_v \\
	\dot\lambda_v &= -\lambda_y - 2n\lambda_u
\end{aligned}\right.
$$

$$
\begin{gathered}
	\ddot\lambda_u = -\dot\lambda_x + 2n\dot\lambda_v = -n^2\lambda_u - 2n\lambda_y \\
	\Rightarrow \lambda_u = C_1\sin nt + C_2\cos nt - \frac2n\lambda_y
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_x = -3C_1n^2\sin nt - 3C_2n^2\cos nt + 6n\lambda_y \\
	\Rightarrow \lambda_x = 3C_1n\cos nt - 3C_2n\sin nt + 6n\lambda_yt + C_3
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_v = -2C_1n\sin nt - 2C_2n\cos nt + 3\lambda_y \\
	\Rightarrow \lambda_v = 2C_1\cos nt - 2C_2\sin nt + 3\lambda_yt + C_4
\end{gathered}
$$

$$
\begin{gathered}
	\dot\lambda_u = C_1n\cos nt - C_2n\cos nt - C_3 + 2nC_4 \\
	\Rightarrow C_3 - 2nC_4 = 0
\end{gathered}
$$

$$
\left\{\begin{aligned}
	\lambda_{x0} &= 3C_1n + C_3 \\
	\lambda_{u0} &= C_2 - \frac2n\lambda_{y0} \\
	\lambda_{v0} &= 2C_1 + C_4
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	C_1 &= -\frac1n\lambda_{x0} + 2\lambda_{v0}\\
    C_2 &= \frac2n\lambda_{y0} + \lambda_{u0} \\
    C_3 &= 4\lambda_{x0} - 6n\lambda_{v0} \\
    C_4 &= \frac2n\lambda_{x0} - 3\lambda_{v0}
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	\lambda_{x} &= (4 - 3\cos nt)\lambda_{x0} + 6(nt - \sin nt)\lambda_{y0} - 3n\sin nt\lambda_{u0} + 6n(\cos nt - 1)\lambda_{v0} \\
	\lambda_{u} &= -\frac{\sin nt}n\lambda_{x0} + \frac{2(\cos nt - 1)}n\lambda_{y0} + \cos nt\lambda_{u0} + 2\sin nt\lambda_{v0} \\
	\lambda_{v} &= \frac{2(1 - \cos nt)}n\lambda_{x0} + \frac{3nt - 4\sin nt}n\lambda_{y0} - 2\sin nt\lambda_{u0} + (4\cos nt - 3)\lambda_{v0}
\end{aligned}\right.
$$

## Total

$$
\boldsymbol\Phi_\lambda(t) = 
\left[\begin{array}{}
4 - 3\cos nt & 6(nt - \sin nt) & 0 & -3n\sin nt & 6n(\cos nt - 1) & 0 \\
0 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & \cos nt & 0 & 0 & n\sin nt\\
-\frac{\sin nt}n & \frac{2(\cos nt - 1)}n & 0 &\cos nt  & 2\sin nt & 0 \\
\frac{2(1 - \cos nt)}n & \frac{3nt - 4\sin nt}n & 0 & -2\sin nt & 4\cos nt - 3 & 0 \\
0 & 0 & -\frac{\sin nt}n & 0 & 0 & \cos nt
\end{array}\right]
= \boldsymbol\Phi^{\mathrm T}(-t)
$$

$$
\left\{\begin{aligned}
	\ddot\lambda_u &= 3n^2\lambda_u + 2n\dot\lambda_v \\
	\ddot\lambda_v &= -2n\dot\lambda_u \\
	\ddot\lambda_w &= -n^2\lambda_w
\end{aligned}\right.
$$

$$
\left\{\begin{aligned}
	\lambda_{u} &= \rho \sin (n t+\psi)-2c_1 \\
	\lambda_{v} &= 2 \rho \cos (n t+\psi)+3c_{1} nt+c_{2} \\
	\lambda_{w} &= \alpha \sin (n t+\psi)+\beta \cos (n t+\psi)
\end{aligned}\right.
$$

## Rendezvous

$$
\lambda_{4,f} = \lambda_{5,f} = \lambda_{6,f} = 0
$$

$$
\begin{aligned}
\lambda_{4,f} &= -\frac{\sin nt_f}n \lambda_{1,0} + \frac{2(\cos nt_f - 1)}n \lambda_{2,0} + \cos nt_f  \lambda_{4,0} + 2\sin nt_f \lambda_{5,0} = 0 \\
\lambda_{5,f} &= \frac{2(1 - \cos nt_f)}n \lambda_{1,0} + \frac{3nt_f - 4\sin nt_f}n \lambda_{2,0} - 2\sin nt_f \lambda_{4,0} + (4\cos nt_f - 3)\lambda_{5,0} = 0 \\
\lambda_{6,f} &= -\frac{\sin nt_f}n \lambda_{3,0} + \cos nt_f \lambda_{6,0} = 0
\end{aligned}
$$

$$
\begin{aligned}
\lambda_{4,0} &= \frac{\sin nt_f\lambda_{1,0} + (6nt_f\sin nt_f + 14\cos nt_f - 14)\lambda_{2,0}}{n(4 - 3\cos nt_f)} \\
\lambda_{5,0} &= \frac{2(1 - \cos nt_f)\lambda_{1,0} + (4\sin nt_f - 3nt_f\cos nt_f)\lambda_{2,0}}{n(4 - 3\cos nt_f)} \\
\lambda_{6,0} &= \frac{\tan nt_f}n \lambda_{3,0}
\end{aligned}
$$

```mathematica
Solve[-Sin[nt] / n l1 + 2 (Cos[nt] - 1)/n l2 +Cos[nt]x+2 Sin[nt]y==0&&2(1-Cos[nt])/n l1 + (3 nt - 4Sin[nt])/n l2 - 2Sin[nt]x + (4Cos[nt] - 3)y==0,{x,y}]

{{x -> -((
    6 l2 - 14 l2 Cos[nt] + 8 l2 Cos[nt]^2 - l1 Sin[nt] - 
     6 l2 nt Sin[nt] + 8 l2 Sin[nt]^2)/(
    n (-3 Cos[nt] + 4 Cos[nt]^2 + 4 Sin[nt]^2))), 
  y -> -((-4 l1 - 4 l1 Cot[nt]^2 - 8 l2 Csc[nt] + 
     4 l1 Cot[nt] Csc[nt] + 6 l2 nt Cot[nt] Csc[nt])/(
    2 n (4 + 4 Cot[nt]^2 - 3 Cot[nt] Csc[nt])))}}
    
(-14 l2 + 14 l2 Cos[nt] + (l1 + 6 l2 nt) Sin[nt])/(n (4 - 3 Cos[nt]))

(2 l1 - 2 l1 Cos[nt] - 3 l2 nt Cos[nt] + 4 l2 Sin[nt])/(4 n - 3 n Cos[nt])
```

