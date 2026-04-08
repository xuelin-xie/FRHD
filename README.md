# FRHD
Implementation of “Spatial-Spectral Adaptive Fidelity and Noise Prior Reduction Guided Hyperspectral Image Denoising”

The code will be uploaded immediately after the paper is published online.

# Introduction
A regularized Kriging model that penalizes the hyperparameter $\theta$ in the Gaussian stochastic process.
![image](https://github.com/xuelin-xie/FRHD/blob/main/FRHD_model.png)

# Contents 
![image](https://github.com/xuelin-xie/FRHD/blob/main/FRHD_flowchart.png)
These are the function files for the Theta-regularized Kriging model, all involved code is compressed in the 'Theta-regularized Kriging.zip' file. The main content includes the code of TRK model and GSCV algorithm.

# Key Finding 1
![image](https://github.com/xuelin-xie/FRHD/blob/main/key_finding1.png)
Theorem 1. In the ADMM framework, with proper parameter scaling, the denoising frameworks in Definitions 1 and 2 yield identical updates for $\mathcal{X}$, $\mathcal{S}$, and $\mathcal{D}$.

# Key Finding 2
![image](https://github.com/xuelin-xie/FRHD/blob/main/key_finding2.png)
The Pixel-wise denoising paradigm:
\begin{align}
& \underset{\mathcal{X}, \mathcal{N}, \mathcal{W}}{\text{min}}\,   \overbrace{\mathcal{R}(\mathcal{X})}^{\text{Image Prior}}\hspace{-0.5em} + \hspace{0.2em} \lambda \hspace{-0.4em} \overbrace{\mathcal{P}(\mathcal{N})}^{\text{Noise Prior}} \hspace{-0.5em} + \hspace{0.2em} \alpha \hspace{-0.5em} \overbrace{\mathcal{J}(\mathcal{W})}^{\text{Weight Prior}}\!\!\!, \quad s.t. \hspace{0.8em}  \underbrace{\mathcal{W  \odot  (Y - X)= N}}_{\text{Fidelity Constraints}},
\end{align}
can effectively improve the model's denoising capabilities.

# Key advantages
1) Fast;
2) High precision.

# How to Cite
To use these codes, please cite the paper: Xuelin Xie, Xiliang Lu, Zhengshan Wang, Yang Zhang, and Long Chen. Spatial-Spectral Adaptive Fidelity and Noise Prior Reduction Guided Hyperspectral Image Denoising. Appl. Math. Model., 2026, xx: xxx. (To be published)

# Contact
The FRHD model for MATLAB is supported by Supercomputing Center of Wuhan University. If you have any questions, please feel free to contact us: xl.xie@whu.edu.cn (Xuelin Xie).
