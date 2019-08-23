function [im_inverse, im_inverse_b] = my_inverse(img, H, D0)
% Input（im_f：退化图片，H：退化模型，D0：半径）
% Output（im_inverse：全逆滤波结果，im_inverse_b：半径受限逆滤波）

[M,N] = size(img);
img = mat2gray(img,[0 255]);
G = fftshift(fft2(img));

%% 全逆滤波
im_F0 = G ./ H;                                % 做F{原始图像}的估计G/H
im_inverse = real(ifft2(ifftshift(im_F0)));    % 频域 > 空域
im_inverse = im2uint8(mat2gray(im_inverse));

%% 半径受限逆滤波
for i = 1 : M 
    for j = 1 : N
        if sqrt( (i-M/2).^2 + (j-M/2).^2 ) < D0   % 仅处理图像中心半径内的点
            G(i,j) = G(i,j) ./ H(i,j);
        end
    end
end
im_inverse_b = real(ifft2(ifftshift( G )));    % 频域 > 空域
im_inverse_b = im2uint8(mat2gray(im_inverse_b));

end