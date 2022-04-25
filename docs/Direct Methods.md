# 直接法

$$
\dot{\boldsymbol x} = \boldsymbol f(\boldsymbol x, \boldsymbol u) = \boldsymbol A \boldsymbol x + \boldsymbol B \boldsymbol u
$$

$$
\boldsymbol T = T \left[\begin{array}{c}
\cos\beta\cos\alpha \\
\cos\beta\sin\alpha \\
\sin\beta
\end{array}\right]
$$




## 性能指标

### 能量最优

$$
J = \frac12\int_{t_0}^{t_f}\boldsymbol u^2\mathrm{d}t
$$

### 燃料最优

$$
J = \int_{t_0}^{t_f}u\mathrm{d}t
$$

### 时间最优

$$
J = t_f = \int_0^{t_f}1\mathrm{d} t \\
$$

$$
\boldsymbol{x}_{\mathrm{nlp}}=\left[\begin{array}{c}
\boldsymbol x_i\\
\boldsymbol u_i\\
t_f
\end{array}\right] \\
\boldsymbol u_i = \left[\begin{array}{cc}\alpha_i&\beta_i\end{array}\right]^{\mathrm{T}}
$$

## 高斯伪谱法