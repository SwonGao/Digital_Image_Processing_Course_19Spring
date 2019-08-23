clc,clear;
im = imread('Fig1034(a)(marion_airport).tif');
%{
sigma = 2;
im_edge = canny(im,sigma,0.06);
imshow(im_edge);

houghmask1 = Hough(im_edge,-pi/2,-pi/2+pi/180, pi/2-pi/180,pi/2);
houghmask2 = Hough(im_edge,-pi/2,-pi/2, pi/2,pi/2);
subplot(121); 
imshow(houghmask1+im2double(im));
title("90 +- 1 ¶È");
subplot(122);
imshow(houghmask2+im2double(im)); 
title("90¶È");

%}
clc,clear;
im = imread('Fig1038(a)(noisy_fingerprint).tif');
im_binary = GlobalThreshold(im,0.01);
figure;imshow(im_binary);

im = imread('Fig1039(a)(polymersomes).tif');
im_otsu = Otsu(im);
figure;imshow(im_otsu);

im = imread('Fig1046(a)(septagon_noisy_shaded).tif');
im_div = division(im,2,3);
figure;imshow(im_div);
