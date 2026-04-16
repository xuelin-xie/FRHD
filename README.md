# FRHD
Implementation of “Spatial-Spectral Adaptive Fidelity and Noise Prior Reduction Guided Hyperspectral Image Denoising”

# Introduction
This work proposes an ADMM-based FRHD model with noise prior reduction and adaptive pixel-wise weighting. It is fast, accurate, and designed for mixed noise removal in hyperspectral images.
![image](https://github.com/xuelin-xie/FRHD/blob/main/FRHD_model.png)

# Contents
These are the function files for the FRHD model, all involved code is compressed in the 'FRHD_main.zip' file. The framework of this work is:
![image](https://github.com/xuelin-xie/FRHD/blob/main/FRHD_flowchart.png)

# Key Finding 1
**Theorem 1**. In the ADMM framework, with proper parameter scaling, the denoising frameworks in Definitions 1 and 2 yield identical updates for $\mathcal{X}$, $\mathcal{S}$, and $\mathcal{D}$.
![image](https://github.com/xuelin-xie/FRHD/blob/main/key_finding1.png)

# Key Finding 2
![image](https://github.com/xuelin-xie/FRHD/blob/main/key_finding2.png)
The Pixel-wise denoising paradigm:

$$
\min_{\mathcal{X}, \mathcal{N}, \mathcal{W}} \mathcal{R}(\mathcal{X}) + \lambda \mathcal{P}(\mathcal{N}) + \alpha \mathcal{J}(\mathcal{W}), \quad \text{s.t.} \quad \mathcal{W} \odot (\mathbf{Y} - \mathbf{X}) = \mathcal{N}
$$

where $\mathcal{R}(\mathcal{X})$ is the Image Prior, $\mathcal{P}(\mathcal{N})$ is the Noise Prior, and $\mathcal{J}(\mathcal{W})$ is the Weight Prior. The constraint represents the Fidelity Constraints.

This formulation can effectively improve the model's denoising capabilities.

# Key advantages
1) Fast;
2) High precision.

# Limitations
FRHD may require careful parameter tuning for optimal performance.

# How to Cite
If you find this code or our work helpful, we would really appreciate a citation to our paper. Thank you!

Paper citation:
Xuelin Xie, Xiliang Lu, Zhengshan Wang, Yang Zhang, and Long Chen. Spatial-Spectral Adaptive Fidelity and Noise Prior Reduction Guided Hyperspectral Image Denoising. Appl. Math. Model., 2026.

# Contact
The FRHD model for MATLAB is supported by Supercomputing Center of Wuhan University. If you have any questions, please feel free to contact us: xl.xie@whu.edu.cn (Xuelin Xie).
