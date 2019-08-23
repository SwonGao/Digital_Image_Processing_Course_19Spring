%%
clc; 
clear;
close all;

%%
ratio_1 = 0.2; 
ratio_2 = 3;   
 filename = 'lenna'; %test image1
% filename = 'cameraman'; %test image2
% filename = 'building'; %test image3

im = imread([filename, '.jpg']);
im = rgb2gray(im);
im = im2double(im);
[row, col, channel] = size(im); 
im_center = im(floor(row*3/8):floor(row*5/8), floor(col*3/8):floor(col*5/8), :); % get a middle image


%% expand ratio_1 (<1)
im1_n = myNearest(im, ratio_1);
im1_b = myBilinear(im, ratio_1);
im1_c = myBicubic(im, ratio_1);

%% shrink ratio_2 (>1)
im2_n = myNearest(im_center, ratio_2);
im2_b = myBilinear(im_center, ratio_2);
im2_c = myBicubic(im_center, ratio_2);

%% save as result
imwrite(im1_n, sprintf('result/_%s_%.1f_n.jpg', filename, ratio_1));
imwrite(im1_b, sprintf('result/_%s_%.1f_b.jpg', filename, ratio_1));
imwrite(im1_c, sprintf('result/_%s_%.1f_c.jpg', filename, ratio_1));
imwrite(im2_n, sprintf('result/_%s_%.1f_n.jpg', filename, ratio_2));
imwrite(im2_b, sprintf('result/_%s_%.1f_b.jpg', filename, ratio_2));
imwrite(im2_c, sprintf('result/_%s_%.1f_c.jpg', filename, ratio_2));

%% figure show the results 
figure(1); 
subplot(221); imshow(im); title('原图'); axis on
subplot(222); imshow(im1_n); title('最近邻内插图像'); axis on
subplot(223); imshow(im1_b); title('双线性内插图像'); axis on
subplot(224); imshow(im1_c); title('双立方内插图像'); axis on

figure(2);
subplot(221); imshow(im_center); title('原图'); axis on
subplot(222); imshow(im2_n); title('最近邻内插图像'); axis on
subplot(223); imshow(im2_b); title('双线性内插图像'); axis on
subplot(224); imshow(im2_c); title('双立方内插图像'); axis on