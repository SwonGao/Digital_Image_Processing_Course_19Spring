function Line = Hough(im,theta1,theta2,theta3,theta4)
[M,N] = size(im);


rousize = ceil(norm([M N]));
theta = -pi/2 : pi/rousize/2 : pi/2;
[~,thetan] = size(theta);

houghmatrix = zeros(rousize*2+1, thetan);

for i = 1 : M
    for j = 1 : N
        if im(i,j) == 1
            rou = round( i * cos(theta) + j * sin(theta) );
            rou = rousize+1+rou;
            for k = 1 : thetan
                houghmatrix(rou(k),k) = houghmatrix(rou(k),k) + 1;
            end
        end
    end
end
houghmatrix = uint8(houghmatrix);




%%
therhold = M*0.3;
Line = zeros(M,N);

N1 = round((theta1+pi/2)/(pi/rousize/2))+1;
N2 = round((theta2+pi/2)/(pi/rousize/2))+1;
for m = 1 : (2*rousize+1)
    for n = N1:N2
        if (double(houghmatrix(m,n)) > therhold)
            theta = n*pi/rousize/2 - pi/2;
            rou = m -rousize - 1;
            for i = 1 : M
                x = round( (rou -cos(theta)*i)/sin(theta) );
                if (x>1 && x<M)
                    Line(i,x) = 1;
                end
            end
        end
    end
end
N3 = round((theta3+pi/2)/(pi/rousize/2))+1;
N4 = round((theta4+pi/2)/(pi/rousize/2))+1;
for m = 1 : (2*rousize+1)
    for n = N3:N4
        if (double(houghmatrix(m,n)) > therhold)
            theta = n*pi/rousize/2 - pi/2;
            rou = m - rousize - 1;
            for i = 1 : M
                x = round( (rou -cos(theta)*i)/sin(theta) );
                if (x>1 && x<M)
                    Line(i,x) = 1;
                end
            end
        end
    end
end

end