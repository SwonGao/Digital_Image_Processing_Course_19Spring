function imnew = GlobalThreshold(im,deltaT)
[M,N] = size(im);
im = uint8(im);
T = mean2(im)/255;

condition = true;
while(condition)
    imnew = imbinarize(im,T);
    sum0 = 0; n0 = 0;
    sum1 = 0; n1 = 0;
    for i = 1:M
        for j = 1:N
            if imnew(i,j) == 0
                sum0 = sum0 + double(im(i,j));
                n0 = n0+1;
            else
                sum1 = sum1 + double(im(i,j));
                n1 = n1+1;
            end
        end
    end
    ave0 = double(sum0) / n0;
    ave1 = double(sum1) / n1;
    Tnew = (ave0+ave1)/2/255;
    if abs(Tnew - T) < deltaT
        condition = false;
    end
    T = Tnew;
end
end