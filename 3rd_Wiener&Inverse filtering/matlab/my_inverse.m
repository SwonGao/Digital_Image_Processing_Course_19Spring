function [im_inverse, im_inverse_b] = my_inverse(img, H, D0)
% Input��im_f���˻�ͼƬ��H���˻�ģ�ͣ�D0���뾶��
% Output��im_inverse��ȫ���˲������im_inverse_b���뾶�������˲���

[M,N] = size(img);
img = mat2gray(img,[0 255]);
G = fftshift(fft2(img));

%% ȫ���˲�
im_F0 = G ./ H;                                % ��F{ԭʼͼ��}�Ĺ���G/H
im_inverse = real(ifft2(ifftshift(im_F0)));    % Ƶ�� > ����
im_inverse = im2uint8(mat2gray(im_inverse));

%% �뾶�������˲�
for i = 1 : M 
    for j = 1 : N
        if sqrt( (i-M/2).^2 + (j-M/2).^2 ) < D0   % ������ͼ�����İ뾶�ڵĵ�
            G(i,j) = G(i,j) ./ H(i,j);
        end
    end
end
im_inverse_b = real(ifft2(ifftshift( G )));    % Ƶ�� > ����
im_inverse_b = im2uint8(mat2gray(im_inverse_b));

end