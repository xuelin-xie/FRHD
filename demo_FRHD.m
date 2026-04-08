clear;
clc;
%%%% Important: For standardization, we convert the original data values ​​to the range of 0-1.
addpath(genpath(pwd));

%% Test Data
%%% 1. bands <=100
% % test1  CAVE Cropped image 200*200*31
% load glass_tiles
% O_Img=double(O_Img(101:300,101:300,:));

% % test2 PaC, University of Pavia, Cropped image 300*300*103
% load paviaU_cropped
% O_Img = paviaU_cropped;

% % test3,  WDC, Washington DC MALL, 256*256*191
load Ori_WDC
O_Img = Img;


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
O_Img = O_Img_normalized;

%% Noise
noisychoose=3;
if noisychoose==1        % Gaussian noise
    % Case 1. Mixed noise 1, Gaussian 0.1 + Impulse noise 0.15
    Nosiy_case='Mixed1 --> Gaussian 0.1 + Impulse noise 0.15';
    nSig = 0.1;
    N_Img_Gaussian = O_Img + nSig * randn(size(O_Img));  % add Gaussian noise
    salt_pepper_ratio = 0.15;  % Impulse noise ratio (between 0 and 1)
    N_Img_Mix1 = N_Img_Gaussian;
    num_salt = round(salt_pepper_ratio * M * N * bands / 2);
    salt_idx = randperm(M * N * bands, num_salt);
    pepper_idx = randperm(M * N * bands, num_salt);
    N_Img_Mix1(salt_idx) = 1;
    N_Img_Mix1(pepper_idx) = 0;
    N_Img = N_Img_Mix1;
elseif noisychoose==2
    % Case 2. Mixed noise 2: Gaussian 0.1 + Deadline noise 0.2
    Nosiy_case='Mixed2 --> Gaussian 0.1 + Deadline noise 0.2';
    nSig = 0.1;
    N_Img_Gaussian = O_Img + nSig * randn(size(O_Img));
    N_Img_Mix2 = N_Img_Gaussian;
    stripeRatio = 0.2;  % Stripe ratio
    numStripes = round(N * stripeRatio);  % Number of stripes
    stripeOffset = 1;  % Fixed offset of stripes
    for b = 1:bands
        stripeColumns = randperm(N, numStripes);
        for c = stripeColumns
            N_Img_Mix2(:, c, b) = 0;
        end
    end
    N_Img =N_Img_Mix2;
elseif noisychoose==3
    % Case 3. Mix 3: Gaussian 0.2 + Impulse noise 0.1 + Deadline noise 0.1
    Nosiy_case='Mixed3 --> Gaussian 0.2 + Impulse noise 0.1 + Deadline noise 0.1';
    nSig = 0.2;
    N_Img_Gaussian = O_Img + nSig * randn(size(O_Img));
    N_Img_Mix3 = N_Img_Gaussian;
    % Impulse
    salt_pepper_ratio = 0.1;  % Impulse noise ratio (between 0 and 1)
    num_salt = round(salt_pepper_ratio * M * N * bands / 2);
    salt_idx = randperm(M * N * bands, num_salt);
    pepper_idx = randperm(M * N * bands, num_salt);
    N_Img_Mix3(salt_idx) = 1;
    N_Img_Mix3(pepper_idx) = 0;
    % Stripe
    stripeRatio = 0.1;  % Stripe ratio
    numStripes = round(N * stripeRatio);  % Number of stripes
    stripeOffset = 1;  % Fixed offset of stripes
    for b = 1:bands
        stripeColumns = randperm(N, numStripes);
        for c = stripeColumns
            N_Img_Mix3(:, c, b) = 0;
        end
    end
    N_Img =N_Img_Mix3;
elseif noisychoose==4
    % Case 4. Mix 4: Gaussian 0.1 + Impulse noise 0.2 + Deadline noise 0.2
    Nosiy_case='Mixed4 --> Gaussian 0.1 + Impulse noise 0.2 + Deadline noise 0.2';
    nSig = 0.1;
    N_Img_Gaussian = O_Img + nSig * randn(size(O_Img));
    N_Img_Mix4 = N_Img_Gaussian;
    % Impulse
    salt_pepper_ratio = 0.2;  % Impulse noise ratio (between 0 and 1)
    num_salt = round(salt_pepper_ratio * M * N * bands / 2);
    salt_idx = randperm(M * N * bands, num_salt);
    pepper_idx = randperm(M * N * bands, num_salt);
    N_Img_Mix4(salt_idx) = 1;
    N_Img_Mix4(pepper_idx) = 0;
    % Stripe
    stripeRatio = 0.2;  % Stripe ratio
    numStripes = round(N * stripeRatio);  % Number of stripes
    stripeOffset = 1;  % Fixed offset of stripes
    for b = 1:bands
        stripeColumns = randperm(N, numStripes);
        for c = stripeColumns
            N_Img_Mix4(:, c, b) = 0;
        end
    end
    N_Img =N_Img_Mix4;
else
    % Case 5. Mix 5: Gaussian 0.15 + Impulse noise 0.15 + Deadline noise 0.15
    Nosiy_case='Mixed5 --> Gaussian 0.15 + Impulse noise 0.15 + Deadline noise 0.15';
    nSig = 0.15;
    N_Img_Gaussian = O_Img + nSig * randn(size(O_Img));
    N_Img_Mix5 = N_Img_Gaussian;
    % Impulse
    salt_pepper_ratio = 0.15;  % Impulse noise ratio (between 0 and 1)
    num_salt = round(salt_pepper_ratio * M * N * bands / 2);
    salt_idx = randperm(M * N * bands, num_salt);
    pepper_idx = randperm(M * N * bands, num_salt);
    N_Img_Mix5(salt_idx) = 1;
    N_Img_Mix5(pepper_idx) = 0;
    % Stripe
    stripeRatio = 0.15;  % Stripe ratio
    numStripes = round(N * stripeRatio);  % Number of stripes
    stripeOffset = 1;  % Fixed offset of stripes
    for b = 1:bands
        stripeColumns = randperm(N, numStripes);
        for c = stripeColumns
            N_Img_Mix5(:, c, b) = 0;
        end
    end
    N_Img =N_Img_Mix5;
end

%% Noisy
if Comparison_Nosiy == 1
    i=i+1;
    Time(i) = 0;
    [PSNR(i), SSIM(i), FSIM(i), ERGAS(i), MSAM(i)] = MSIQA(O_Img*255, N_Img*255);
    disp(['Method Name: None', ', Time = None', ', MPSNR = ' num2str(PSNR(i),'%5.2f')  ...
        ', MSSIM = ' num2str(SSIM(i),'%5.4f'), ', The case of noise is: ' num2str(Nosiy_case)]);
    Methods{i} = 'Noisy';
end

%% FRHD    % tau is the most sensitive parameter that requires fine-tuning.
if Comparison_FRHD== 1
    i=i+1;
    % paramater setting
    if noisychoose==1       % Gaussian + Impulse
        rank = 3;                    %    CAVE: 4;   PaC: 3  WDC: 5
        tau = 0.47*[1, 1];           %    CAVE: 1*[1, 1];   PaC: 0.5*[1, 1]; WDC: 0.47*[1, 1];
        Rpara = [1, 0];              %    CAVE[1, 0],  PaC: [0.95, 0];  WDC: [1.05, 0]
    elseif noisychoose==2   % Gaussian + Deadline
        rank = 4;                    %    PaC:3   CAVE, WDC: 4
        tau = 0.001*[1, 1];          %    CAVE:  3*[1, 1];  PaC, WDC: 0.001*[1, 1];
        Rpara = [2.1, 1];            %    CAVE:  [2.1, 1];    PaC, WDC: [1.3, 0.7]
    else                    % Gaussian + Impulse + Deadline
        rank = 3;
        tau = 0.1*[1, 1];            %    CAVE: 2.5*[1, 1];  PAC: 1*[1, 1];    WDC: 0.1*[1, 1];
        Rpara = [1.5, 2.5];          %    [Impulse, Deadline]
    end
    tic
    [FRHD_Img, W, S, D] = FRHD_Denoising(N_Img, tau, Rpara, rank);
    Time(i) = toc;
    [PSNR(i), SSIM(i), FSIM(i), ERGAS(i), MSAM(i)] = MSIQA(O_Img*255, FRHD_Img*255);
    disp(['Method Name: FRHD', ', Time = ' num2str(Time(i)), ', MPSNR = ' num2str(PSNR(i),'%5.2f')  ...
        ', MSSIM = ' num2str(SSIM(i),'%5.4f'), ', The case of noise is: ' num2str(Nosiy_case)]);
    Methods{i} = 'FRHD';
end

%% Show the results
Indexes = [PSNR; SSIM; FSIM; ERGAS; MSAM; Time];
results = array2table(Indexes, ...
    'VariableNames', Methods', ...
    'RowNames', {'PSNR', 'SSIM', 'FSIM', 'ERGAS', 'MSAM', 'Time'});
results.Properties.DimensionNames = {'Indexes', 'Methods'};
disp(results);


%% Visual Comparison
bands = [152, 106, 20]; % CAVE 14/23/16; PAC 6/20/50; WDC 152/106/20

figure('Name', 'HSI Denoising Comparison', 'Position', [100, 100, 800, 400]);
subplot(1,2,1);
imshow(N_Img(:,:,bands));
noisy_title = sprintf('Noisy\nPSNR: %.2f  SSIM: %.4f', PSNR(1), SSIM(1));
title(noisy_title, 'FontSize', 11, 'FontWeight', 'bold');
xlabel(['Bands: ', num2str(bands)]);
subplot(1,2,2);
imshow(FRHD_Img(:,:,bands));
frhd_title = sprintf('FRHD Denoised\nPSNR: %.2f  SSIM: %.4f', PSNR(end), SSIM(end));
title(frhd_title, 'FontSize', 11, 'FontWeight', 'bold');
xlabel(['Bands: ', num2str(bands)]);
