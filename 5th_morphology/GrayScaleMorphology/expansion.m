function im_new = expansion(im , StructuralElement)
    [M,N] = size(im);
    [m,n] = size(StructuralElement);
    dx = (1+m)/2;
    dy = (1+n)/2;
    imnew = zeros(M+m-1,N+n-1);
    imnew(dx:dx-1+M , dy:dy-1+N) = im;
    temp = imnew;
    for i = dx : M+dx-1
        for j = dy : N+dy-1   %����
            max = 0;
            for a = 1 : m     
                for b = 1 : n
                    if ( StructuralElement(a,b) == 1 )
                        if(imnew(i+a-dx,j+b-dx) > max )
                            max = imnew(i+a-dx,j+b-dx);
                        end
                    end
                end %�������� S.E.Ϊ1�����ص㸳ֵ1
            end
            temp(i,j) = max;
        end
    end
    im_new = temp(1+dx-1:M+dx-1 , 1+dy-1:N+dy-1); 
    im_new = uint8(im_new);
end