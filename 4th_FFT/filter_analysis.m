function [w_d,w_row,w_col,w_hor] = filter_analysis(im,h0,h1)
[M,N] = size(im);
for i = 1:M
    temp0(i,:) = conv(im(i,:) , h0 , 'same');
    temp1(i,:) = conv(im(i,:) , h1 , 'same');
    for j = 1:floor(N/2)
        temp0_s(i,j) = temp0(i,2*j);
        temp1_s(i,j) = temp1(i,2*j);
    end
end %完成行卷积、列采样


for j = 1:floor(N/2)
    temp00(:,j) = conv(temp0_s(:,j) , h0 , 'same');
    temp01(:,j) = conv(temp0_s(:,j) , h1 , 'same');
    temp10(:,j) = conv(temp1_s(:,j) , h0 , 'same');
    temp11(:,j) = conv(temp1_s(:,j) , h1 , 'same');
    for i = 1 : floor(M/2)
        w_d(i,j) = temp00(i*2,j);
        w_row(i,j) = temp01(i*2,j);
        w_col(i,j) = temp10(i*2,j);
        w_hor(i,j) = temp11(2*i,j);
    end
end
end