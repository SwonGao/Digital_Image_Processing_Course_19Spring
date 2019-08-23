clc,clear;
im = imread("Fig0929(a)(text_image).tif");
subplot(221);   imshow(im);   title("原图");

%% 长字符提取结果
SE = ones(51,1);
SE2 = ones(3,3);

imcor = corrosion(im,SE);
%垂直腐蚀一次
imexp = imcor;
for i = 1 : 100
    imexp = expansion(imexp,SE2);
    imexp = imexp .* im;
end
%100次够了
subplot(222);   imshow(imexp);    title("长字符提取结果");

%% 空洞填充结果
%im = im;
SE = ones(3,3);
imbar = 1 - im;
F = getF_fillhole(im);

for i = 1: 1000
F = expansion(F,SE);
F = F .* imbar;
end
imnew = 1 - F;
subplot(223);   imshow(imnew);    title("空洞填充结果");


%% 边界清除结果
%im = im;
SE = ones(3,3);
F = getF_edge(im);
for i = 1 : 100
    F = expansion(F,SE);
    F = F .* im;
end
imnew = im - F;
subplot(224);   imshow(imnew);  title("边界清除结果");

