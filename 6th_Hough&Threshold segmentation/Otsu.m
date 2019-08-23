function imnew = Otsu(im)
im = uint8(im);
[M,N] = size(im);
L = zeros(1,256);
P = zeros(1,256);
m = P;
for i = 1 : M
    for j = 1 : N
        L(im(i,j)+1) = L(im(i,j)+1) + 1;
    end
end
L = L./M/N;
P(1) = L(1);
m(1) = L(1)*0;
for i = 2 : 256
    P(i) = L(i) + P(i-1);
    m(i) = (i-1)* L(i) + m(i-1);
end
mg = m(256);
squareB = (mg.*P-m).^2./(P.*(1-P));

k = getmax(squareB);
i = 0:1:255;
squareG = sum( (i-mg).^2.*P );

n = squareB(k+1)/squareG.^2
k = k/255;
imnew = imbinarize(im,k);
end


function k = getmax(square)
max = 0;
temp = 1;
for i = 1: 256
    if square(i) > max
        max = square(i);
        ks = i-1;
    end
end
for i = 1:256
    if square(i) == max
        ks(temp) = i-1;
        temp = temp+1;
    end
end
k = round(mean(ks));
end
    