function SE2 = getcircleSE(radius)
    SE2 = zeros(2*radius+1, 2*radius+1);
    for i = 1 : 2*radius
        for j = 1 : 2*radius
            if sqrt((radius+1-i)^2+(radius+1-j)^2) <= radius
                SE2(i,j) = 1;
            end
        end
    end
end