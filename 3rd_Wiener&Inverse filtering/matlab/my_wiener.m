function im_wiener = my_wiener(img, H, K)
% Input��im_f���˻�ͼƬ��H���˻�ģ�ͣ�K��ά���˲�������

abs_H2 = abs(H) .^2;

img = mat2gray(img,[0 255]);
G = fftshift(fft2(img));
F = ((1./H) .* abs_H2 ./ ( abs_H2 + K ) ) .* G;

im_wiener = real(ifft2(ifftshift(F)));    % Ƶ�� > ����
im_wiener = im2uint8(mat2gray(im_wiener));
