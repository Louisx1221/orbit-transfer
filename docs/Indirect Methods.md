# 间接法

$$
\dot{\boldsymbol x} = \boldsymbol f(\boldsymbol x, \boldsymbol u) = \boldsymbol A \boldsymbol x + \boldsymbol B \boldsymbol u
$$

$$
J = \Phi(\boldsymbol x_f, t_f) + \int_{t_0}^{t_f}L(\boldsymbol x, \boldsymbol u, t)\mathrm{d}t
$$

$$
H = L + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f
$$

$$
\dot{\boldsymbol{\lambda}} = -\frac{\partial H}{\partial \boldsymbol{x}}
$$

$$
\frac{\partial H}{\partial \boldsymbol u} = 0
$$


## 性能指标

### 能量最优

$$
J = \frac12\int_{t_0}^{t_f}\boldsymbol u^2\mathrm{d}t
$$

$$
H = L + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f = \frac12\boldsymbol u^2 + \boldsymbol \lambda^{\mathrm{T}}(\boldsymbol A \boldsymbol x + \boldsymbol B \boldsymbol u)
$$

$$
\dot{\boldsymbol \lambda} = -\frac{\partial H}{\partial \boldsymbol{x}} = -\boldsymbol A^\mathrm{T}\boldsymbol\lambda
$$

$$
\frac{\partial H}{\partial \boldsymbol u} = \boldsymbol u + \boldsymbol B^{\mathrm{T}} \boldsymbol \lambda = 0 \\
\Rightarrow \boldsymbol u = -\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda
$$

### 燃料最优

$$
\dot{\boldsymbol x} = \boldsymbol f(\boldsymbol x, \boldsymbol u) = \boldsymbol A \boldsymbol x + a_\max u\boldsymbol B\boldsymbol\alpha, \quad 0\leqslant u\leqslant 1
$$

同伦

$$
J = \int_{t_0}^{t_f}u\mathrm{d}t \\
\rightarrow J = \int_{t_0}^{t_f}(1-\varepsilon)u + \varepsilon u^2\mathrm{d}t
$$

$$
H = L + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f = \boldsymbol \lambda^{\mathrm{T}}\boldsymbol A \boldsymbol x + u\left(\varepsilon u + 1 - \varepsilon + a_\max\boldsymbol\lambda^\mathrm{T}\boldsymbol B\boldsymbol \alpha\right)
$$

$$
(u, \boldsymbol \alpha) = \arg\min H
$$

$$
\boldsymbol \alpha = -\frac{\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda}{\|\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda\|}
$$

$$
u=\left\{\begin{aligned}
&0,&\rho>\varepsilon \\
&\frac12-\frac\rho{2\varepsilon},&\|\rho\|\leqslant\varepsilon \\
&1, &\rho<-\varepsilon
\end{aligned}\right.
$$

开关函数

$$
\rho=1-a_\max\|\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda\|
$$

### 时间最优

$$
J = t_f = \int_0^{t_f}1\mathrm{d} t \\
\Phi = t_f, \quad \mathrm{or} \quad L = 1
$$

$$
H = L + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f = 1 + \boldsymbol \lambda^{\mathrm{T}}(\boldsymbol A \boldsymbol x + \boldsymbol B \boldsymbol u)
$$

$$
\boldsymbol u = \arg\min H = -\frac{\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda}{\|\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda\|}u_\max
$$

$$
\left.\left(\frac{\partial \boldsymbol \Phi}{\partial t_f} + H\right)\right|_{t_f} = 1 + \boldsymbol \lambda^{\mathrm{T}}(t_f)\left[\boldsymbol A \boldsymbol x(t_f) + \boldsymbol B \boldsymbol u(t_f)\right] = 0
$$

- [ ] 时域变换


$$
\tau = \frac{t}{t_f - t_0} \\
\boldsymbol X = [\boldsymbol x, \boldsymbol \lambda, t_f] \\
\dot{\boldsymbol X(\tau)} = (t_f - t_0) \cdot [\dot{\boldsymbol x}(t), \dot{\boldsymbol \lambda}(t), 0]
$$

$$
\boldsymbol{ceq}=[\boldsymbol x_0, \boldsymbol x_f, \boldsymbol \lambda_f]
$$

- [x] 粒子群

罚函数



## 两点边值问题

### 直接打靶法

$$
\boldsymbol{ceq}=\left[\begin{array}{c}
\boldsymbol x(t_f) - \boldsymbol x_f\\
\lambda_m(t_f)
\end{array}\right] = \boldsymbol 0
$$

