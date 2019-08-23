function [img_2] = mySharpen(img_1)

img_1 = im2double(img_1);
size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);

% 请在下面继续完成图像锐化功能代码
exp_img_2 = zeros(h+2,w+2);
exp_img_2(2:h+1,2:w+1) = img_1;
lp = [-1 -1 -1; -1 8 -1; -1 -1 -1];
for i = 2 : h+1
    for j = 2: w+1
        sum = 0;
        for m = -1 : +1
            for n = -1 : +1
                sum = sum + lp(2+m,2+n)*exp_img_2(i+m,j+n);
            end
        end
        img_2(i-1,j-1) = exp_img_2(i,j) + sum;
    end
end

img_2 = (im2double(img_2));
end