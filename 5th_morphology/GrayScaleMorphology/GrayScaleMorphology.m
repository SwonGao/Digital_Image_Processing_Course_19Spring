clc,clear;
%% 顶帽变换

im = imread("Fig0940(a)(rice_image_with_intensity_gradient).tif");
SE2 = getcircleSE(40);
subplot(231); imshow(im);
subplot(232); imshow(imbinarize(im));
imnew = corrosion(im,SE2);
imnew2 = expansion(imnew,SE2);
subplot(234); imshow(imnew2);
subplot(235); imshow(abs(im - imnew2));
subplot(236); imshow(imbinarize(im-imnew2));

%% 粒度测定
clc;clear;
im = imread("Fig0941(a)(wood_dowels).tif");
core = ones(3,3)./9;
figure; subplot(231); imshow(im);
im_ave = uint8(filter2(core,im));
subplot(232); imshow(im_ave);

SE1 = getcircleSE(10);
imnew1 = corrosion(im,SE1); 
imnew1 = expansion(imnew1,SE1);
subplot(233); imshow(imnew1);

SE2 = getcircleSE(20);
imnew2 = corrosion(im,SE2);
imnew2 = expansion(imnew2,SE2);
subplot(234); imshow(imnew2);

SE3 = getcircleSE(25);
imnew3 = corrosion(im,SE3);
imnew3 = expansion(imnew3,SE3);
subplot(235); imshow(imnew3);

SE4 = getcircleSE(30);
imnew4 = corrosion(im,SE4);
imnew4 = expansion(imnew4,SE4);
subplot(236); imshow(imnew4);

%% 纹理分割
clc;clear;
im = imread("Fig0943(a)(dark_blobs_on_light_background).tif");
core = ones(3,3)./9;
im = uint8(filter2(core,im));
figure; subplot(221); imshow(im);
SE = getcircleSE(30);
imnew = expansion(im,SE);
imnew = corrosion(imnew,SE);
subplot(222); imshow(imnew);

SE = getcircleSE(60);
imnew2 = corrosion(imnew, SE);
imnew2 = expansion(imnew2,SE);
subplot(223); imshow(imnew2);

[m,n] = size(imnew2);
imnew2 = imbinarize(imnew2);
plus = zeros(m,n);
for i = 1 : m
    for j = 3 : n-2 
        if imnew2(i,j) == 0
            %plus(i,j-2) = 1;
            plus(i,j-1) = 255;
            plus(i,j) = 255;
            plus(i,j+1) = 255;
            %plus(i,j+2) = 1;
            break;
        end 
    end
end
im_fin = im + uint8(plus);
subplot(224); imshow(im_fin);