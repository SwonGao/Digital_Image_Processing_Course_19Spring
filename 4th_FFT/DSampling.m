function im_mod = DSampling(im)
    m = size(im);
    for i = 1 : floor(m(1,1)/2)
        for j = 1 : floor(m(1,2)/2)
            im_mod(i,j) = im(i*2,j*2);
        end
    end
end