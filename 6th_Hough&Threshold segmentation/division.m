function imnew = division(im,column,row)
[M,N] = size(im);
m = floor(M/column);
n = floor(N/row);
k = 1;
a = zeros(1,column+1);
a(1) = 1;
for i = 2 : column+1
    a(i) = a(i-1) + m;
end
while(a(column+1) > M)
    a(column+1) = a(column+1) -1;
end
b = zeros(1,row+1);
b(1) = 1;
for j = 2 : row+1
    b(j) = b(j-1) + n;
end
while(b(row+1) > N)
        b(row+1) = b(row+1) - 1;
end
for i = 1: column
    for j = 1: row
        imnew(a(i):a(i+1),b(j):b(j+1)) = Otsu( im(a(i):a(i+1),b(j):b(j+1)) );
    end
end
end
