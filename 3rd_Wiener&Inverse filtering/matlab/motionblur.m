function [H, im_blured] = motionblur(img, sigma)
a = double(0.1);
b = double(0.1);
T = double(1);
i = 0 + 1j;
[M,N] = size(img);
[u,v]=meshgrid(1:M,1:N);    % ���ɶ�ά����ϵ
temp = pi .* ( ( (u-M/2) .*a + (v-N/2) .*b) +eps );
H = T .* sin(temp) .* exp(-i*temp) ./temp ; % �˻�����

img = mat2gray(img,[0 255]);
G = fftshift(fft2(img));          % ���� > Ƶ��
G = G .* H;
G = real(ifft2(ifftshift(G)));    % Ƶ�� > ����
im_blured = im2double(mat2gray(G));
noise = normrnd(0,sigma,M,N);
im_blured = im_blured + noise;
im_blured = im2uint8(im_blured);

