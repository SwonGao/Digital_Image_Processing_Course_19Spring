function [img_2] = myAverage(img_1)

size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);
%% 请在下面继续完成均值滤波功能代码
exp_img_2 = zeros(h+2,w+2);
exp_img_2(2:h+1,2:w+1) = img_1;
for i = 1:h
    for j = 1:w
        img_2(i,j) = ave(exp_img_2,i+1,j+1);
    end
end
img_2 = uint8(img_2);
end

function [value] = ave(exp_img_2,i,j)
    value = exp_img_2(i-1,j-1) + exp_img_2(i-1,j) + exp_img_2(i-1,j+1) +exp_img_2(i,j-1) + exp_img_2(i,j) +exp_img_2(i,j+1) + exp_img_2(i+1,j-1) +exp_img_2(i+1,j) + exp_img_2(i+1,j+1);
    value = value / 9; 
end