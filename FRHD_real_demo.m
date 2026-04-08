clear;
clc;
%%%% Important: For standardization, we convert the original data values ​​to the range of 0-1.
addpath(genpath(pwd));

%% Test Data
load Urban

%% Comparison Methods
%   1.  SDeCNN,          2020  TGRS
%   2.  WNLRATV,         2022  TGRS
%   3.  RCTV,            2022  TGRS
%   4.  FastHyMix,       2023  TNNLS
%   5.  TPTV,            2023  TGRS
%   6.  CTVSPCP,         2024  SIAM
%   7.  FBGND,           2024  TCI
%   8.  FallHyDe,        2024  TGRS
%   9.  Ours (FRHD)

Comparison_Nosiy     = 1;
Comparison_FRHD      = 1;

%% Basic settings
i=0;
setdemorandstream(pi);  % Setting the random seed
[M, N, bands] = size(O_Img);
% Convert to a value between 0 and 1
O_Img_normalized = zeros(M, N, bands);
for b = 1:bands
    min_val = min(min(O_Img(:,:,b)));  % Minimum value of the current band
    max_val = max(max(O_Img(:,:,b)));  % Maximum value of the current band
    O_Img_normalized(:,:,b) = (O_Img(:,:,b) - min_val) / (max_val - min_val);
end
N_Img = O_Img_normalized;

%% FRHD
if Comparison_FRHD== 1
    i=i+1;
    % Gaussian + Impulse + Deadline
    rank = 3;
    tau = 0.1*[1, 1];
    Rpara = [1.5, 2.5];    % These parameters are the same as those selected by WDC.
    tic
    [FRHD_Img, W, S, D] = FRHD_Denoising(N_Img, tau, Rpara, rank);
    Time(i) = toc;
    fprintf('Execution time of the FRHD method: %.4f seconds\n', Time(i));
end

%% Show the results
bands = [2, 150, 206];
figure('Name', 'Noisy Image (RGB Bands)');
subplot(1,2,1); imshow(N_Img(:,:,bands)); title('Noisy');
subplot(1,2,2); imshow(FRHD_Img(:,:,bands)); title('FRHD');
