clc; clear;
%% 近似金字塔和预测残差金字塔
im = imread('demo-1.jpg');
im = im2double(rgb2gray(im));
sigma = 1;
gausFilter = fspecial('gaussian', [5,5], sigma);    %高斯滤波
im_f1 = imfilter(im, gausFilter, 'replicate');
im_f1 = DSampling(im_f1);                           %下采样函数
im_1 = myBilinear(im_f1);
sub_1 = im - im_1;
subplot(241); imshow(im);
subplot(242); imshow(im_f1);
subplot(245); imshow(mat2gray(sub_1));

im_f2 = imfilter(im_f1, gausFilter, 'replicate');
im_f2 = DSampling(im_f2);                           %下采样函数
im_2 = myBilinear(im_f2);
sub_2 = im_f1 - im_2;
subplot(243); imshow(im_f2);
subplot(246); imshow(mat2gray(sub_2));

im_f3 = imfilter(im_f2, gausFilter, 'replicate');
im_f3 = DSampling(im_f3);                           %下采样函数
im_3 = myBilinear(im_f3);
sub_3 = im_f2 - im_3;
subplot(244); imshow(im_f3);
subplot(247); imshow(mat2gray(sub_3));
subplot(248); imshow(mat2gray(sub_3));


