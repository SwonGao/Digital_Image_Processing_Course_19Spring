function im_new = corrosion(im , StructuralElement)
    [M,N] = size(im);
    [m,n] = size(StructuralElement);
    dx = (1+m)/2;
    dy = (1+n)/2;
    imnew = ones(M+m-1,N+n-1) .* inf;
    imnew(dx:dx-1+M , dy:dy-1+N) = im;
    temp = imnew;
    for i = dx : M+dx-1
        for j = dy : N+dy-1   %居中
            min =Inf;
            for a = 1 : m     
                for b = 1 : n
                    if ( StructuralElement(a,b) == 1 )
                        if(imnew(i+a-dx,j+b-dx) < min )
                            min = imnew(i+a-dx,j+b-dx);
                        end
                    end
                end %对于所有 S.E.为1的像素点赋值1
            end
            temp(i,j) = min;
        end
    end
    im_new = temp(1+dx-1:M+dx-1 , 1+dy-1:N+dy-1); 
    im_new = uint8(im_new);
end