function im_new = corrosion(im , StructuralElement)
    [M,N] = size(im);    
    [m,n] = size(StructuralElement);
    dx = (1+m)/2;   
    dy = (1+n)/2;
    imnew = zeros(M+m-1,N+n-1);
    imnew(dx:dx-1+M , dy:dy-1+N) = im;  
    temp = imnew; 
    % 零延拓
    for i = dx: M+dx-1
        for j = dy: N+dy-1
            flag = 1;
            for a = 1 : m     
                for b = 1 : n
                    if( StructuralElement(a,b) == 1 )
                        if (imnew(i+a-dx,j+b-dy) == 0) 
                            flag = 0;
                        end 
                    end %如果发现结构元=1的地方原图像不等于1: flag = 0;
                end
                if flag == 0 
                    break;
                end % 节约算力
            end %块运算
            if (flag == 0)
                temp(i,j) = 0;
            else
                temp(i,j) = imnew(i,j);
            end
        end
    end
	im_new = temp(1+dx-1:M+dx-1 , 1+dy-1:N+dy-1);
end
