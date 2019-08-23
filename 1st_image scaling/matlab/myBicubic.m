function [img_2] = myBicubic(img_1, n)

size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);
img_1broad = zeros(h_1+5, w_1+5);
img_1broad(3:h_1+2, 3:w_1+2) = img_1;
img_1 = img_1broad;
for i = 1:h_2
    for j = 1:w_2
        x = floor(i / n)+2;
		u = i/n - floor(i/n);
        y = floor(j / n)+2;
		v = j/n - floor(j/n);
        img_2(i,j) = calculate(img_1,x,y,u,v);
    end
end 
end

%% sealed
function result=interpolation(x)

a = -0.5;   
x = abs(x);
x2 = x*x;
x3 = x*x2;
if x <= 1
    result = 1 - ( a + 3 ) * x2 + ( a + 2 ) * x3;
elseif x <= 2
    result = -4 * a + 8 * a* x - 5 * a * x2  + a * x3;
else
    result = 0;
end
end

function sum = calculate(img_1, i,j,u,v)

sum = 0;
for row = -1:2
	for column = -1:2
		sum = sum + img_1(i+row, j+column)*interpolation(row-u)*interpolation(column-v);
    end
end
end