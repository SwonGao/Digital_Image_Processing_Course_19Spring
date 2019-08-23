function [im] = filter_reconstruct(w_d,w_row,w_col,w_hor,g0,g1)
[M,N] = size(w_d);
for j = 1: N
    for i = 1: 2*M
        if mod(i,2) == 0
            temp_d(i,j) = w_d(i/2,j);
            temp_row(i,j) = w_row(i/2,j);
            temp_col(i,j) = w_col(i/2,j);
            temp_hor(i,j) = w_hor(i/2,j);
        else
            temp_d(i,j) = 0;
            temp_row(i,j) = 0;
            temp_col(i,j) = 0;
            temp_hor(i,j) = 0;
        end
    end
    temp_d(:,j) = conv(temp_d(:,j) , g0 , 'same');
    temp_row(:,j) = conv(temp_row(:,j) , g1 , 'same');
    temp_col(:,j) = conv(temp_col(:,j) , g0 , 'same');
    temp_hor(:,j) = conv(temp_hor(:,j) , g1 , 'same');
end %完成 行上采样 & 列卷积

temp1 = temp_d + temp_row;
temp2 = temp_col + temp_hor;
for i = 1 : 2* M
    for j = 1 : 2*N
        if mod(j,2) == 0
            temp11(i,j) = temp1(i,j/2);
            temp22(i,j) = temp2(i,j/2);
        else
            temp11(i,j) = 0;
            temp22(i,j) = 0;
        end
    end
    temp11(i,:) = conv(temp11(i,:) , g0 , 'same');
    temp22(i,:) = conv(temp22(i,:) , g1 , 'same');
end %列上采样，行卷积
im = temp11 + temp22;
end