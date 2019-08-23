function pro = get_input()
N = 100;
pro = zeros(1,256);
pixel = 0;
for i=1:N
    A=imread(['train\im_' num2str(i) '.bmp']);
    A = rgb2gray(A);
    [M,N] = size(A);
    for j = 1:M
        for k = 1:N
            pro(A(j,k)+1) = pro(A(j,k)+1)+ 1;
        end
    end
    pixel = pixel + M*N;
end

pro = pro/pixel;
save pro;
end