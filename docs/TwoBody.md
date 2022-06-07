# Two-body Problem

## Intercept

动力学方程
$$
\dot{\boldsymbol{r}}=\boldsymbol{v}, \quad \dot{\boldsymbol{v}}=\boldsymbol{g}+\frac{\boldsymbol{T}}{m}, \quad \dot{m}=-\frac{T}{c}
$$
性能指标
$$
J = t_f
$$
哈密顿量
$$
H_=\boldsymbol\lambda_{r}^{T} \boldsymbol{v}+\boldsymbol\lambda_{v}^{T}\left(\boldsymbol{g}+\boldsymbol{T} / m\right)-\boldsymbol\lambda_{m} T / c
$$
最优控制
$$
\boldsymbol T = -\frac{\boldsymbol\lambda_{v}}{\|\boldsymbol\lambda_{v}\|}T
$$

$$
H =\boldsymbol\lambda_{r}^{T} \boldsymbol{v}+\boldsymbol\lambda_{v}^{T}\boldsymbol{g}+TS_{f} \\
$$

开关函数
$$
S_{f} = -\frac{\|\boldsymbol\lambda_{v}\|}{m} - \frac{\lambda_{m}}{c}
$$
协态方程
$$
\dot{\boldsymbol\lambda}_{r}=-\left[\frac{\partial \boldsymbol{g}}{\partial \boldsymbol{r}}\right]^{T} \boldsymbol\lambda_{v}, \quad 
\dot{\boldsymbol\lambda}_{v}=-\boldsymbol\lambda_{r}, 
\quad \dot{\lambda}_{m}=\kappa \frac{T \|\boldsymbol\lambda_{v}\|}{m^{2}}
$$
$$
\frac{\partial \boldsymbol{g}}{\partial \boldsymbol{r}} = \frac{3\mu r_i^2}{r^5} - \frac{\mu}{r^3}
$$

边界条件
$$
\left\{\begin{aligned}
    \boldsymbol r(t_f) &= \boldsymbol r_e(t_f) \\
    \boldsymbol\lambda_{v}(t_f) &= 0 \\
    \boldsymbol\lambda_{m}(t_f) &= 0
\end{aligned}\right.
$$
横截条件
$$
\frac{\partial\Phi}{\partial t_f} + H_f = 1 + \boldsymbol\lambda_{r}(t_f)\boldsymbol v(t_f)
$$
