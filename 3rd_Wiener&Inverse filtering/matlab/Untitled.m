clc; 
clear;
x=imread('demo-2.jpg'); 
x1=x(:,:,1);
x1=double(x1); 
y1=fftshift(fft2(x1));
[M,N]=size(y1); 
figure(1);
imshow(x1,[]);
title('原始的图像') ;
figure(2);
imshow(abs(y1),[0,250000]);
title('原始的图像频谱');
m=1:M; 
m1=1:N; 
[m,m1]=meshgrid(m,m1);%生成网格空间 
noise=20.*imnoise(zeros(M,N),'gaussian',0,0.008);%高斯噪声 
figure(3);  
subplot(1,2,1);
imshow(noise,[]);
title('白噪声') ;
a=double(21/100);%x方向的最大移动量为ra的0.21倍,可调 
b=double(21/100);%y方向的最大移动量为ca的0.21倍,可调 
t=double(88/100);%移动到最大所需的时间默认为0.88

f=zeros(M,N);   
g=(m-M/2-1).*a+(m1-N/2-1).*b+eps;   
f=t.*sin(pi.*g).*exp(-(0+1j).*pi.*g)./(pi.*g);
h=f'.*y1; 


tu=ifft2(h);  
tu=abs(tu)+noise; 
subplot(1,2,2);
imshow(tu,[]);
title('退化的图像')%原图傅立叶变换估计值 
y1=h./f'; 
figure(4)
subplot(1,2,1);
imshow(abs(ifft2(y1)),[]);
title('逆滤波的结果');
h=fftshift(fft2(tu));
x=fftshift(fft2(noise));
K=x.*conj(x)./(y1.*conj(y1));%计算K值  
w=(f.*conj(f))'.*h./(f.*(f.*conj(f)+K'))'; 
weina=abs(ifft2(w)); 
subplot(1,2,2);
imshow(weina,[]);
title('维纳滤波的结果');
