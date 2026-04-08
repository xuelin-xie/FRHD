# FRHD
Implementation of “Spatial-Spectral Adaptive Fidelity and Noise Prior Reduction Guided Hyperspectral Image Denoising”

The code will be uploaded immediately after the paper is published online.

# Introduction
A fast and robust pixel-wise model combined with the total variation regularizer for representative coefficients to accurately remove mixed noise in hyperspectral images.
![image](https://github.com/xuelin-xie/FRHD/blob/main/FRHD_model.png)

# Contents 
![image](https://github.com/xuelin-xie/FRHD/blob/main/FRHD_flowchart.png)
These are the function files for the FRHD model, all involved code is compressed in the 'FRHD.zip' file.

# Key Finding 1
**Theorem 1**. In the ADMM framework, with proper parameter scaling, the denoising frameworks in Definitions 1 and 2 yield identical updates for $\mathcal{X}$, $\mathcal{S}$, and $\mathcal{D}$.
![image](https://github.com/xuelin-xie/FRHD/blob/main/key_finding1.png)

# Key Finding 2
![image](https://github.com/xuelin-xie/FRHD/blob/main/key_finding2.png)
The Pixel-wise denoising paradigm:
$$
\min_{\mathcal{X}, \mathcal{N}, \mathcal{W}} \, \overbrace{\mathcal{R}(\mathcal{X})}^{\text{Image Prior}} + \lambda \overbrace{\mathcal{P}(\mathcal{N})}^{\text{Noise Prior}} + \alpha \overbrace{\mathcal{J}(\mathcal{W})}^{\text{Weight Prior}}, \quad s.t. \quad \underbrace{\mathcal{W} \odot (\mathbf{Y} - \mathbf{X}) = \mathcal{N}}_{\text{Fidelity Constraints}}
$$
can effectively improve the model's denoising capabilities.

# Key advantages
1) Fast;
2) High precision.

# How to Cite
To use these codes, please cite the paper: Xuelin Xie, Xiliang Lu, Zhengshan Wang, Yang Zhang, and Long Chen. Spatial-Spectral Adaptive Fidelity and Noise Prior Reduction Guided Hyperspectral Image Denoising. Appl. Math. Model., 2026, xx: xxx. (To be published)

# Contact
The FRHD model for MATLAB is supported by Supercomputing Center of Wuhan University. If you have any questions, please feel free to contact us: xl.xie@whu.edu.cn (Xuelin Xie).
