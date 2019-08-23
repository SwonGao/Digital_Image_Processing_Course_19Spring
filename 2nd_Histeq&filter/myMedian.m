function [img_2] = myMedian(img_1)

size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);

% 请在下面继续完成中值滤波功能代码
exp_img_2 = zeros(h+2,w+2);
exp_img_2(2:h+1,2:w+1) = img_1;
for i = 1:h
    for j = 1:w
        img_2(i,j) = mid(exp_img_2,i+1,j+1);
    end
end
img_2 = uint8(img_2);
end

function [value] = mid(im, i , j)
% 求中值
array=zeros(1,9);
k=1;
for m = -1:1
    for n = -1:1
    array(1,k) = im(i+m,j+n);
    k=k+1;
    end
end
for m = 1 : 5
    for n = m + 1 : 9
        if array(1,m) > array(1,n);
            temp = array(1,n);
            array(1,n) = array(1,m);
            array(1,m) = temp;
        end
    end
end
value =array(1,5);
end