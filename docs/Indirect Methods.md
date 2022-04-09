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
H = L + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f = \frac12\boldsymbol u^2 + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f
$$

$$
\frac{\partial H}{\partial \boldsymbol u} = \boldsymbol u + \boldsymbol B \boldsymbol \lambda^{\mathrm{T}} = 0 \\
\Rightarrow \boldsymbol u = -\boldsymbol B \boldsymbol \lambda^{\mathrm{T}}
$$

### 时间最优

$$
J = t_f = \int_0^{t_f}1\mathrm{d} t \\
\Phi = t_f, \quad \mathrm{or} \quad L = 1
$$

$$
H = L + \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f = \boldsymbol \lambda^{\mathrm{T}}\boldsymbol f
$$

$$
\boldsymbol u = \arg\min H = -\frac{\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda}{||\boldsymbol B^{\mathrm{T}} \boldsymbol \lambda||}u_\max \\
$$

$$
H(t_f) + \frac{\partial \Phi}{\partial t_f} = 1 + \boldsymbol \lambda^{\mathrm{T}}(t_f)\boldsymbol f(t_f) = 0
$$

$$
\tau = \frac{t}{t_f - t_0} \\
\boldsymbol X = [\boldsymbol x, \boldsymbol \lambda, t_f] \\
\dot{\boldsymbol X(\tau)} = (t_f - t_0) \cdot [\dot{\boldsymbol x}(t), \dot{\boldsymbol \lambda}(t), 0]
$$

$$
\boldsymbol{ceq}=[\boldsymbol x_0, \boldsymbol x_f, \boldsymbol \lambda_f]
$$

### 能量最优

$$
J = \int_{t_0}^{t_f}||\boldsymbol u||\mathrm{d}t
$$

$$
J = \int_{t_0}^{t_f}(1-\varepsilon)||\boldsymbol u|| + \varepsilon\boldsymbol u^2\mathrm{d}t
$$


$$
\boldsymbol u = -\frac{\boldsymbol \lambda}{||\boldsymbol \lambda||}
$$

## 两点边值问题

### 直接打靶法

$$
\boldsymbol{ceq}=\left[\begin{array}{c}
\boldsymbol x(t_f) - \boldsymbol x_f\\
\lambda_m(t_f)
\end{array}\right] = \boldsymbol 0
$$

