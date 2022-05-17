# 形状法

## 柱坐标系

柱坐标系(cylindrical coordinate system, CyCS)

### $v$

$$
x = \left[\begin{array}{cccccc}
r & \theta & z & v_r & v_\theta & v_z
\end{array}\right]^{\mathrm{T}}
$$

$$
\dot{\boldsymbol{x}}=
\left[\begin{array}{c}
v_{r} \\
v_{\theta} / r \\
v_{z} \\
v_{\theta}^{2} / r-\mu r / R^{3} \\
-v_{r} v_{\theta} / r \\
-\mu z / R^{3}
\end{array}\right]+\frac{T_{\max } u}{m}\left[\begin{array}{c}
0_{3 \times 3} \\
I_{3 \times 3}
\end{array}\right] \boldsymbol{\alpha}
$$

式中，$R = \sqrt(r^2 + z^2)$
$$
\dot{\boldsymbol x} = J_F(\boldsymbol x)\boldsymbol x + \boldsymbol B\boldsymbol u \\
\boldsymbol B = \left[\begin{array}{c}
0_{3 \times 3} \\
I_{3 \times 3}
\end{array}\right]
$$
Jacobian矩阵
$$
J_{F}\left(x_{1}, \ldots, x_{n}\right) =\frac{\partial\left(y_{1}, \ldots, y_{m}\right)}{\partial\left(x_{1}, \ldots, x_{n}\right)}
=\left[\begin{array}{ccc}
\frac{\partial y_{1}}{\partial x_{1}} & \cdots & \frac{\partial y_{1}}{\partial x_{n}} \\
\vdots & \ddots & \vdots \\
\frac{\partial y_{m}}{\partial x_{1}} & \cdots & \frac{\partial y_{m}}{\partial x_{n}}
\end{array}\right]
$$

$$
J_{F}(\boldsymbol{x})=
\frac{\partial \dot{\boldsymbol x}}{\partial \boldsymbol x}
=\left[\begin{array}{cccccc}
0 & 0 & 0 & 1 & 0 & 0 \\
-v_{\theta} / r^{2} & 0 & 0 & 0 & 1 / r & 0 \\
0 & 0 & 0 & 0 & 0 & 1 \\
-v_{\theta}^{2} / r^{2}+\mu\left(3 r^{2}-R^{2}\right) / R^{5} & 0 & 3 \mu r z / R^{5} & 0 & 2 v_{\theta} / r & 0 \\
v_{r} v_{\theta} / r^{2} & 0 & 0 & -v_{\theta} / r & -v_{r} / r & 0 \\
3 \mu r z / R^{5} & 0 & \mu\left(3 z^{2}-R^{2}\right) / R^{5} & 0 & 0 & 0
\end{array}\right]
$$

### $\mathrm{d}/\mathrm{d}t$ 

$$
x = \left[\begin{array}{cccccc}
r & \theta & z & \dot v & \dot \theta & \dot z
\end{array}\right]^{\mathrm{T}}
$$

$$
\dot{\boldsymbol{x}}=
\left[\begin{array}{c}
\dot r \\
\dot \theta \\
\dot z \\
r \dot \theta^{2} - \mu r / R^{3} \\
-2\dot r \dot \theta / r \\
-\mu z / R^{3}
\end{array}\right]+\frac{T_{\max } u}{m}
\left[\begin{array}{ccc}
0 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
1 & 0 & 0 \\
0 & 1/r & 0 \\
0 & 0 & 1
\end{array}\right] \boldsymbol{\alpha}
$$

$$
J_{F}(\boldsymbol{x})=\left[\begin{array}{cccccc}
0 & 0 & 0 & 1 & 0 & 0 \\
0 & 0 & 0 & 0 & 1 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 \\
\dot \theta^{2} +\mu\left(3 r^{2}-R^{2}\right) / R^{5} & 0 & 3 \mu r z / R^{5} & 0 & 2 r \dot \theta & 0 \\
2\dot r \dot \theta / r^{2}  - T_\theta / r^2 & 0 & 0 & -2 \dot \theta / r & -2\dot r / r & 0 \\
3 \mu r z / R^{5} & 0 & \mu\left(3 z^{2}-R^{2}\right) / R^{5} & 0 & 0 & 0
\end{array}\right]
$$

## 形状路径

标称轨道

$$
\delta \dot{\boldsymbol{x}}=J_F\left(\boldsymbol{x}_{\mathrm{nom}}\right) \delta \boldsymbol{x}+\left[\begin{array}{l}
0_{3 \times 3} \\
I_{3 \times 3}
\end{array}\right]\left(\frac{u T_{\mathrm{max}}}{m} \boldsymbol{\alpha}-\boldsymbol{a}_{\mathrm{nom}}\right)
$$

动力学及欧拉-拉格朗日方程
$$
\left[\begin{array}{c}
\delta \dot{\boldsymbol{x}} \\
\dot{\boldsymbol\lambda}_{x}
\end{array}\right]=\left[\begin{array}{cc}
\boldsymbol M\left(\boldsymbol{x}_{\mathrm{nom}}\right) & {\left[\begin{array}{cc}
\boldsymbol 0_{3 \times 3} & \boldsymbol 0_{3 \times 3} \\
\boldsymbol 0_{3 \times 3} & -\frac{I_{\mathrm{ss}} g_{0} T_{\max }}{2 m^{2}} I_{3 \times 3}
\end{array}\right]} \\
\boldsymbol 0_{6 \times 6} & -\boldsymbol M^{T}\left(\boldsymbol{x}_{\mathrm{nom}}\right)
\end{array}\right]\left[\begin{array}{l}
\delta \boldsymbol{x} \\
\boldsymbol \lambda_{x}
\end{array}\right]-\left[\begin{array}{l}
\boldsymbol 0_{3 \times 1} \\
\boldsymbol{a}_{\mathrm{nom}} \\
\boldsymbol 0_{6 \times 1}
\end{array}\right]
$$
形状路径(Shape-Base Path)
$$
\left[\begin{array}{c}
\frac{\mathrm{d} \delta \boldsymbol{x}}{\mathrm{d} s} \\
\frac{\mathrm{d} \lambda_{x}}{\mathrm{~d} s}
\end{array}\right]=F(s)\left[\begin{array}{c}
\delta \boldsymbol{x} \\
\lambda_{x}
\end{array}\right]-f(s)
$$

式中，$F = J_F \frac{\mathrm{d}t}{\mathrm{d}s}$及$f = B\frac{\mathrm{d}t}{\mathrm{d}s}$
$$
\boldsymbol{y}\left(s_{f}\right)=\Phi\left(s_{f}, s_{0}\right) \boldsymbol{y}\left(s_{0}\right)-\int_{s_{0}}^{s_{f}} \Phi\left(s_{f}, v\right) \boldsymbol{f}(v) \mathrm{d} v
$$

式中，$\boldsymbol \Phi = e^{\boldsymbol F}$
$$
\Phi\left(s_{f}, s_{0}\right)=\left[\begin{array}{ll}
\Phi_{1,1} & \Phi_{1,2} \\
\Phi_{2,1} & \Phi_{2,2}
\end{array}\right]
$$

$$
\delta \boldsymbol{x}\left(s_{f}\right)=\Phi_{1,1} \delta \boldsymbol{x}\left(s_{0}\right)+\Phi_{1,2} \lambda_{x}\left(s_{0}\right)-z_{1}
$$

$$
\left[\begin{array}{c}z_1\\z_2\end{array}\right] = \int_{s_{0}}^{s_{f}} \Phi\left(s_{f}, v\right) \boldsymbol{f}(v) \mathrm{d} v
$$

协态变量初值
$$
\boldsymbol\lambda_{x}\left(s_{0}\right)=\Phi_{1,2}^{-1}\left(\delta \boldsymbol{x}\left(s_{f}\right)-\Phi_{1,1} \delta \boldsymbol{x}\left(s_{0}\right)+z_{1}\right)
$$

由于式(14)的积分难求，故采用数值方式求解，打靶方程
$$
\begin{aligned}
	\boldsymbol \Psi\left(\boldsymbol\lambda_x\left(s_0\right)\right)
	&= \delta \boldsymbol{x}\left(s_{f}\right) + \boldsymbol{x}_{\mathrm{nom}}\left(s_{f}\right) - \boldsymbol x_{\mathrm{sc}}\left(t_{f}\right) \\
	&= \Phi_{1,1} \delta \boldsymbol{x}\left(s_{0}\right)+\Phi_{1,2} \lambda_{x}\left(s_{0}\right)-z_{1} + \boldsymbol{x}_{\mathrm{nom}}\left(s_{f}\right) \\
	&= \boldsymbol 0 \\
\end{aligned}
$$
式中，$\boldsymbol x_{\mathrm{sc}}$为瞬时轨道，对于标称轨道$\boldsymbol x_{\mathrm{nom}}(s_0) = x_{\mathrm{sc}}(t_0)$，$\boldsymbol x_{\mathrm{nom}}(s_f) = x_{\mathrm{sc}}(t_f)$，上式可简化为$\boldsymbol \Psi\left(\boldsymbol\lambda_x\left(s_0\right)\right) = \delta \boldsymbol{x}\left(s_{f}\right) = \boldsymbol 0$

从任意初值$\bar{\boldsymbol \lambda}$，用有限差分方法用来获得式(16)的雅可比矩阵，而雅可比矩阵实际上是$\Phi_{1,2}$。 单次牛顿迭代就可以得到解
$$
\boldsymbol \lambda_x^* = \bar{\boldsymbol \lambda}_x - \Phi_{1,2}^{-1}\boldsymbol \Psi\left(\bar{\boldsymbol \lambda}_x\right)
$$

## 形函数

### 指数正弦

### 逆多项式

### Hodographic-Shaping Method

#### 基函数

| $v(u)$ | $\frac{\mathrm{d}v}{\mathrm{d}u}$ | $\int v\mathrm{d}u$ |
| ------ | --------------------------------- | ------------------- |
| $1$    | $0$                               | $s$                 |
| $u$    | $1$                               | $\frac12{u^2}$      |
| $u^2$  | $2u$                              | $\frac1{3}{u^3}$    |

$$
V(t) = \sum_{i=1}^n c_iv_i(t)
$$

$$
{\left[\begin{array}{ccc}
v_{1}(0) & v_{2}(0) & v_{3}(0) \\
v_{1}\left(t_{f}\right) & v_{2}\left(t_{f}\right) & v_{3}\left(t_{f}\right) \\
\tilde{v}_{1}\left(t_{f}\right)-\tilde{v}_{1}(0) & \tilde{v}_{2}\left(t_{f}\right)-\tilde{v}_{2}(0) & \tilde{v}_{3}\left(t_{f}\right)-\tilde{v}_{3}(0)
\end{array}\right]\left[\begin{array}{l}
c_{1} \\
c_{2} \\
c_{3}
\end{array}\right]}
=\left[\begin{array}{c}
V_{0} \\
V_{f}\\
P_{f}-P_{0}
\end{array}\right]
$$

#### $t$

$$
V_r(0) = c_1 = v_{r,0} \\
V_r(t_f) = c_1 + c_2 t_f + c_3 t_f^2= v_{r,f} \\
r_f - r_0 = \int_0^{t_f} V_r(t) ~\mathrm{d}t = c_1 t_f + c_2\frac{t_f^2}2 + c_3\frac{t_f^3}3
$$


$$
V_{\theta}(0) = c_1 = v_{\theta,0} \\
V_{\theta}(t_f) = c_1 + c_2 t_f + c_3 t_f^2 = v_{\theta,f} \\
\Rightarrow c_2 = \frac{v_{\theta,f} - v_{\theta,0}}{t_f} - c_3 t_f
$$

$$
\theta(t) = \theta_0 + \int_0^t \dot \theta ~\mathrm{d}t = \theta_0 + \int_0^t \frac{V_{\theta}(t)}{r(t)} ~\mathrm{d}t \\
=\theta_0 + \int_0^t \frac{v_{\theta,0} + \left(\frac{v_{\theta,f} - v_{\theta,0}}{t_f} - c_3 t_f\right)t + c_3t^2}{r_0 + c_{r,1}t + c_{r,1}\frac{t^2}{2} + c_{r,1}\frac{t^3}{3}} ~\mathrm{d}t
$$

$$
\theta_f - \theta_0 = c_3\int_0^{t_f}\frac{t(t - t_f)}{r(t)}~\mathrm{d}t + \int_0^{t_f}\frac{v_{\theta,f}t + v_{\theta,0}(t_f - t)}{r(t)t_f}~\mathrm{d}t \Rightarrow c_3
$$

#### $\theta\rightarrow s$ 

$$
\begin{aligned}
&R(0)=V_{r, 0} / \dot{\theta}_{0}, \quad R\left(t_{f}\right)=V_{r, f} / \dot{\theta}_{f}, \quad \int_{0}^{\theta_{f}} R \mathrm{~d} \theta=r_{f}-r_{0} \\
&T(0)=1 / \dot{\theta}_{0}, \quad T\left(t_{f}\right)=1 / \dot{\theta}_{f}, \quad \int_{0}^{\theta_{f}}|T| \mathrm{d} \theta=t_{f}=\mathrm{TOF} \\
&Z(0)=V_{z, 0} / \dot{\theta}_{0}, \quad Z\left(t_{f}\right)=V_{z, f} / \dot{\theta}_{f}, \quad \int_{0}^{\theta_{f}} Z \mathrm{~d} \theta=z_{f}-z_{0}
\end{aligned}
$$

归一化
$$
s(\theta) = \frac{\theta-\theta_0}{\theta_f - \theta_0},\quad s\in[0,1]
$$

$$
\frac{\mathrm{d}s}{\mathrm{d}\theta} = \frac{1}{\theta_f - \theta_0}
\Leftrightarrow \mathrm{d}\theta = (\theta_f - \theta_0)~\mathrm{d}s
$$

$$
\frac{\mathrm{d}s}{\mathrm{d}t} = \frac{\mathrm{d}s}{\mathrm{d}\theta}\cdot\frac{\mathrm{d}\theta}{\mathrm{d}t} = \frac{1}{\theta_f - \theta_0}\cdot\frac1{c_1 + c_2 s + c_3 s^2}
$$

1. $R$

$$
R(\theta) = \frac{\mathrm{d}r}{\mathrm{d}\theta} = \left.\frac{\mathrm{d}r}{\mathrm{d}t} \right/\frac{\mathrm{d}\theta}{\mathrm{d}t} = \frac{rv_r}{v_\theta} \\
R(s) =\frac{\mathrm{d}r}{\mathrm{d}\theta} \cdot\frac{\mathrm{d}\theta}{\mathrm{d}s} = \left(\theta_f - \theta_0\right)\frac{rv_r}{v_\theta} = c_1 + c_2 s + c_3 s^2
$$

$$
\begin{aligned}
	R(0) &= c_1 = \frac{r_0 v_{r,0}}{v_{\theta,0}} \\
	R(t_f) &= c_1 + c_2 + c_3 = \frac{r_f v_{r,f}}{v_{\theta,f}} \\
	\int_{\theta_0}^{\theta_{f}} R ~\mathrm{d} \theta & = (\theta_f - \theta_0)\int_{0}^{1} c_1 + c_2 s + c_3 s^2 ~\mathrm{d} s = \left(\theta_f - \theta_0\right)\left(c_1 + \frac12c_2 + \frac13c_3\right) = r_{f}-r_{0}
\end{aligned}
$$

$$
\left\{\begin{aligned}
	c_1 &= \frac{r_0 v_{r,0}}{v_{\theta,0}} \\
	c_2 &= -4\frac{r_0 v_{r,0}}{v_{\theta,0}} -2\frac{r_f v_{r,f}}{v_{\theta,f}} + 6\frac{r_f - r_0}{\theta_f - \theta_0}\\
	c_3 &= 3\frac{r_0 v_{r,0}}{v_{\theta,0}} + 3\frac{r_f v_{r,f}}{v_{\theta,f}} - 6\frac{r_f - r_0}{\theta_f - \theta_0}
\end{aligned}\right.
$$

2. $T$

$$
\begin{aligned}
	T(0) &= c_1 = \frac{r_0}{v_{\theta,0}} \\
	T(t_f) &= c_1 + c_2 + c_3 = \frac{r_f}{v_{\theta,f}} \\
	\int_{\theta_0}^{\theta_{f}} |T| ~\mathrm{d} \theta & = (\theta_f - \theta_0)\int_{0}^{1} c_1 + c_2 s + c_3 s^2 ~\mathrm{d} s = \left(\theta_f - \theta_0\right)\left(c_1 + \frac12c_2 + \frac13c_3\right) = t_f
\end{aligned}
$$

$$
\left\{\begin{aligned}
	c_1 &= \frac{r_0}{v_{\theta,0}} \\
	c_2 &= -4\frac{r_0}{v_{\theta,0}} -2\frac{r_f}{v_{\theta,f}} + 6\frac{t_f}{\theta_f - \theta_0}\\
	c_3 &= 3\frac{r_0}{v_{\theta,0}} + 3\frac{r_f}{v_{\theta,f}} - 6\frac{t_f}{\theta_f - \theta_0}
\end{aligned}\right.
$$

3. $Z$

同$R$
