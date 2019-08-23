function im_new = expansion(im , StructuralElement)
    [M,N] = size(im);
    [m,n] = size(StructuralElement);
    dx = (1+m)/2;
    dy = (1+n)/2;
    imnew = zeros(M+m-1,N+n-1);
    imnew(dx:dx-1+M , dy:dy-1+N) = im;
    temp = imnew;
    for i = dx : M+dx-1
        for j = dy : N+dy-1   %居中
            %中心点周围的像素值都设置为1；
            if( imnew(i,j) == 1 )   %若成立
                for a = 1 : m     
                    for b = 1 : n
                        if( StructuralElement(a,b) == 1 )
                            temp(i+a-dx,j+b-dy) = 1;
                        else
                            temp(i+a-dx,j+b-dy) = 0;
                        end
                    end %对于所有 S.E.为1的像素点赋值1
                end
            end
        end
    end
    im_new = temp(1+dx-1:M+dx-1 , 1+dy-1:N+dy-1); 
end