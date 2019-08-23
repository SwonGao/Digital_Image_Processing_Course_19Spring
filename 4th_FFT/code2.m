%% 二维快速小波变换
clc; clear;
im = imread('demo-2.tif');
im = im2double(im);
g0 = [0.0322 -0.0126 -0.0992 0.2979 0.8037 0.4976 -0.0296 -0.0758];
g1 = (-1).^(0:1:7) .* g0(end:-1:1);
h0 = g0(end:-1:1);
h1 = g1(end:-1:1);
%% 画图
[w_d,w_row,w_col,w_hor] = filter_analysis(im,h0,h1);
[w_d2,w_row2,w_col2,w_hor2] = filter_analysis(w_d,h0,h1);
[w_d3,w_row3,w_col3,w_hor3] = filter_analysis(w_d2,h0,h1);

im_1 = merge(mat2gray(w_d),mat2gray(w_row),mat2gray(w_col),mat2gray(w_hor));
subplot(131); imshow(im_1);
im_2 = merge(mat2gray(w_d2),mat2gray(w_row2),mat2gray(w_col2),mat2gray(w_hor2));
im_2 = merge(mat2gray(im_2),mat2gray(w_row),mat2gray(w_col),mat2gray(w_hor));
subplot(132); imshow(im_2);
im_3 = merge(mat2gray(w_d3),mat2gray(w_row3),mat2gray(w_col3),mat2gray(w_hor3));
im_3 = merge(mat2gray(im_3),mat2gray(w_row2),mat2gray(w_col2),mat2gray(w_hor2));
im_3 = merge(mat2gray(im_3),mat2gray(w_row),mat2gray(w_col),mat2gray(w_hor));
subplot(133); imshow(im_3);

%% 复原
im_2 = filter_reconstruct(w_d3,w_row3, w_col3,w_hor3,g0,g1);
im_1 = filter_reconstruct(im_2,w_row2, w_col2,w_hor2,g0,g1);
im_mod = filter_reconstruct(im_1,w_row, w_col,w_hor,g0,g1);
figure;
subplot(221);imshow(im);
title("原图");
subplot(224);imshow(im_mod);
title("三级重建图像,MSE=0.1342,PSNR = 130.9076");
[M,N] = size(im);
MSE = sum(sum( (im_mod-im).^2 ))/M/N;
PSNR = 10* log(255*255/MSE);

im_1 = filter_reconstruct(w_d2,w_row2, w_col2,w_hor2,g0,g1);
im_mod = filter_reconstruct(im_1,w_row, w_col,w_hor,g0,g1);
MSE = sum(sum( (im_mod-im).^2 ))/M/N;
PSNR = 10* log(255*255/MSE);
subplot(223);imshow(im_mod);
title("二级重建图像,MSE=0.368,PSNR = 143.8513");

im_mod = filter_reconstruct(w_d,w_row, w_col,w_hor,g0,g1);
MSE = sum(sum( (im_mod-im).^2 ))/M/N;
PSNR = 10* log(255*255/MSE);
subplot(222);imshow(im_mod);
title("一级重建图像,MSE=0.0047,PSNR = 164.4410");

%% 基于小波的边缘检测
figure; subplot(121);
z = zeros(16,16);
im_2 = filter_reconstruct(z,w_row3, w_col3,w_hor3,g0,g1);
im_1 = filter_reconstruct(im_2,w_row2, w_col2,w_hor2,g0,g1);
im0 = filter_reconstruct(im_1,w_row, w_col,w_hor,g0,g1);
imshow(mat2gray(im0)); title("w_d = 0")
subplot(122);
im_2 = filter_reconstruct(z,z, w_col3,w_hor3,g0,g1);
im_1 = filter_reconstruct(im_2,w_row2, w_col2,w_hor2,g0,g1);
im0 = filter_reconstruct(im_1,w_row, w_col,w_hor,g0,g1);
imshow(mat2gray(im0)); title("w_d = 0,w_row = 0")
