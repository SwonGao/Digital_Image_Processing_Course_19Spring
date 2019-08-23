function [img_2] = myBilinear(img_1, n)
size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 =  zeros(h_2, w_2) ;
for i = 1: h_2
    for j = 1: w_2
        cen = [i,j]/n;       % 映射的中心
        fR11 = floor(cen);   % 中心左下角的坐标
        %% 初始条件
        if fR11(1) == 0 && fR11(2) == 0
            img_2(i,j) = img_1(1,1);
            continue;
        end  %(0,0)的条件
        if fR11(1) == 0 && fR11(2) == w_1
            img_2(i,j) = img_1(1, w_1);
            continue;
        end %(0, w_1)
        if fR11(1) == h_1 && fR11(2) == w_1
            img_2(i,j) = img_1(h_1, w_1);
            continue;
        end %(h_1, 0)
        if fR11(1) == h_1 && fR11(2) == 0
            img_2(i,j) = img_1(h_1, 1);
            continue;
        end %(h_1, w_1)
        if fR11(1) == 0
            fR11(1) = 1;
            f_final = (img_1( 1, fR11(2)+1 ) - img_1( 1, fR11(2) ) )* ( cen(2) - fR11(2) ) + img_1(1,fR11(2));
            img_2(i,j) = f_final;
            continue;
        end  %(0,y)
        if fR11(2) == 0
            fR11(2) = 1;
            f_final = (img_1( fR11(1)+1 , 1 ) - img_1( fR11(1), 1 ) )* ( cen(1) - fR11(1) ) + img_1(fR11(1),1);
            img_2(i,j) = f_final;
            continue;
        end  %(x,0)
        
        if fR11(1) == h_1
            f_final = (img_1( h_1, fR11(2)+1 ) - img_1( h_1, fR11(2) ) )* ( cen(2) - fR11(2) ) + img_1( h_1,fR11(2) );
            img_2(i,j) = f_final;
            continue;
        end %(h_1,y)
        if fR11(2) == w_1
            f_final = (img_1( fR11(1)+1 , w_1 ) - img_1( fR11(1), w_1 ) )* ( cen(1) - fR11(1) ) + img_1(fR11(1),w_1);
            img_2(i,j) = f_final;
            continue;
        end  %(x,w_1)
        %% 一般情况
        if cen == fR11 
            img_2(i,j) = img_1(cen(1) , cen(2) );
        end
        %
        fR12 = fR11 + [0 1];
        fR21 = fR11 + [1 0];
        fR22 = fR11 + [1 1];
        % X linear
        f_R1 = img_1( fR11(1), fR11(2) ) + ( img_1( fR21(1), fR21(2) ) - img_1( fR11(1), fR11(2) ) )*( cen(1) - fR11(1) );
        f_R2 = img_1( fR12(1), fR12(2) ) + ( img_1( fR22(1), fR22(2) ) - img_1( fR12(1), fR12(2) ) )*( cen(1) - fR12(1) );
        %f_R1 = img_1( fR11(1), fR11(2) ) * (fR21(1) - cen(1)) + img_1( fR21(1), fR21(2) ) * (cen(1) - fR11(1));
        %f_R2 = img_1( fR12(1), fR12(2) ) * (fR22(1) - cen(1)) + img_1( fR22(1), fR22(2) ) * (cen(1) - fR12(1));
        % Y linear
        f_final = f_R1 + ( f_R2 - f_R1 )*( cen(2) - fR11(2) );
        %f_final = f_R1 * ( fR12(2) - cen(2) ) + f_R1 * ( cen(2) - fR11(2) );
        img_2(i,j) = f_final;
    end
end
%img_2 = uint8(img_2);
end

