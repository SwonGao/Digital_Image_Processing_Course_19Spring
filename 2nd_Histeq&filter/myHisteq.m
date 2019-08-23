function [img_2] = myHisteq(img_1, n)

size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);

%请在下面继续完成直方图均衡化代码

pre = zeros(1,256);
for i = 1:h
    for j = 1:w
        k = img_1(i,j)+1;
        pre(1,k) = pre(1,k) + 1;
    end
end

count = zeros(1,256);
sum = 0;
for i = 1:256
   sum = sum + pre(1,i);
   count(1,i) =round(sum*(n-1)/(h*w));
end

for i = 1:h
    for j = 1:w
        k = img_1(i,j);
        img_2(i,j) = count(1,k+1);
    end
end
img_2 = floor(img_2/(n-1)*255);
img_2 = uint8(img_2);
end