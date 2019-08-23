function F = getF_fillhole(im)
[M,N] = size(im);
F = zeros(M,N);
for i = 1 : M
    for j = 1 : N
        if( i == 1 || i == M || j == 1 || j == N)
            F(i,j) = 1 - im(i,j);
        else
            F(i,j) = 0;
        end
    end
end
