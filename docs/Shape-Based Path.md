# 形状法

## 形状路径

$$
\dot{\boldsymbol x} = \boldsymbol f(\boldsymbol x, \boldsymbol u) = \boldsymbol A \boldsymbol x + \boldsymbol B \boldsymbol u
$$

柱坐标系(cylindrical coordinate system, CyCS)
$$
\dot{\boldsymbol{x}}=\left[\begin{array}{c}
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

标称轨道

$$
\delta \dot{\boldsymbol{x}}=M\left(\boldsymbol{x}_{\mathrm{nom}}\right) \delta \boldsymbol{x}+\left[\begin{array}{l}
0_{3 \times 3} \\
I_{3 \times 3}
\end{array}\right]\left(\frac{u T_{\mathrm{max}}}{m} \boldsymbol{\alpha}-\boldsymbol{a}_{\mathrm{nom}}\right)
$$

Jacobian矩阵
$$
J_{F}\left(x_{1}, \ldots, x_{n}\right) =\frac{\partial\left(y_{1}, \ldots, y_{m}\right)}{\partial\left(x_{1}, \ldots, x_{n}\right)}
=\left[\begin{array}{ccc}
\frac{\partial y_{1}}{\partial x_{1}} & \cdots & \frac{\partial y_{1}}{\partial x_{n}} \\
\vdots & \cdots & \vdots \\
\frac{\partial y_{m}}{\partial x_{1}} & \cdots & \frac{\partial y_{m}}{\partial x_{n}}
\end{array}\right]
$$

$$
M(\boldsymbol{x})=\left[\begin{array}{cccccc}
0 & 0 & 0 & 1 & 0 & 0 \\
-v_{\theta} / r^{2} & 0 & 0 & 0 & 1 / r & 0 \\
0 & 0 & 0 & 0 & 0 & 1 \\
-v_{\theta}^{2} / r^{2}+\mu\left(3 r^{2}-R^{2}\right) / R^{5} & 0 & 3 \mu r z / R^{5} & 0 & 2 v_{\theta} / r & 0 \\
v_{r} v_{\theta} / r^{2} & 0 & 0 & -v_{\theta} / r & -v_{r} / r & 0 \\
3 \mu r z / R^{5} & 0 & \mu\left(3 z^{2}-R^{2}\right) / R^{5} & 0 & 0 & 0
\end{array}\right]
$$

形状路径
$$
\left[\begin{array}{c}
\frac{\mathrm{d} \delta \boldsymbol{x}}{\mathrm{d} s} \\
\frac{\mathrm{d} \lambda_{x}}{\mathrm{~d} s}
\end{array}\right]=F(s)\left[\begin{array}{c}
\delta \boldsymbol{x} \\
\lambda_{x}
\end{array}\right]-f(s)
$$

$$
\boldsymbol{y}\left(s_{f}\right)=\Phi\left(s_{f}, s_{0}\right) \boldsymbol{y}\left(s_{0}\right)-\int_{s_{0}}^{s_{f}} \Phi\left(s_{f}, v\right) \boldsymbol{f}(v) \mathrm{d} v
$$

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

$$
\lambda_{x}\left(s_{0}\right)=\Phi_{1,2}^{-1}\left(\delta \boldsymbol{x}\left(s_{f}\right)-\Phi_{1,1} \delta \boldsymbol{x}\left(s_{0}\right)+z_{1}\right)
$$

## 形函数

### 指数正弦

### 逆多项式

### Hodographic-Shaping Method

基函数

#### $t$

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

#### $\theta$

$$
\begin{aligned}
&R(0)=V_{r, 0} / \dot{\theta}_{0}, \quad R\left(t_{f}\right)=V_{r, f} / \dot{\theta}_{f}, \quad \int_{0}^{\theta_{f}} R \mathrm{~d} \theta=r_{f}-r_{0} \\
&T(0)=1 / \dot{\theta}_{0}, \quad T\left(t_{f}\right)=1 / \dot{\theta}_{f}, \quad \int_{0}^{\theta_{f}}|T| \mathrm{d} \theta=t_{f}=\mathrm{TOF} \\
&Z(0)=V_{z, 0} / \dot{\theta}_{0}, \quad Z\left(t_{f}\right)=V_{z, f} / \dot{\theta}_{f}, \quad \int_{0}^{\theta_{f}} Z \mathrm{~d} \theta=z_{f}-z_{0}
\end{aligned}
$$

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
R(\theta) = \frac{\mathrm{d}r}{\mathrm{d}\theta} = \left.\frac{\mathrm{d}r}{\mathrm{d}t} \right/\frac{\mathrm{d}\theta}{\mathrm{d}t} = \frac{rv_r}{v_\theta} = c_1 + c_2 s + c_3 s^2 = R(s)
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
