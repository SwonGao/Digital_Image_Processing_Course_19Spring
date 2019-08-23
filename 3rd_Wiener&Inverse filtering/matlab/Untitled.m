clc; 
clear;
x=imread('demo-2.jpg'); 
x1=x(:,:,1);
x1=double(x1); 
y1=fftshift(fft2(x1));
[M,N]=size(y1); 
figure(1);
imshow(x1,[]);
title('ԭʼ��ͼ��') ;
figure(2);
imshow(abs(y1),[0,250000]);
title('ԭʼ��ͼ��Ƶ��');
m=1:M; 
m1=1:N; 
[m,m1]=meshgrid(m,m1);%��������ռ� 
noise=20.*imnoise(zeros(M,N),'gaussian',0,0.008);%��˹���� 
figure(3);  
subplot(1,2,1);
imshow(noise,[]);
title('������') ;
a=double(21/100);%x���������ƶ���Ϊra��0.21��,�ɵ� 
b=double(21/100);%y���������ƶ���Ϊca��0.21��,�ɵ� 
t=double(88/100);%�ƶ�����������ʱ��Ĭ��Ϊ0.88

f=zeros(M,N);   
g=(m-M/2-1).*a+(m1-N/2-1).*b+eps;   
f=t.*sin(pi.*g).*exp(-(0+1j).*pi.*g)./(pi.*g);
h=f'.*y1; 


tu=ifft2(h);  
tu=abs(tu)+noise; 
subplot(1,2,2);
imshow(tu,[]);
title('�˻���ͼ��')%ԭͼ����Ҷ�任����ֵ 
y1=h./f'; 
figure(4)
subplot(1,2,1);
imshow(abs(ifft2(y1)),[]);
title('���˲��Ľ��');
h=fftshift(fft2(tu));
x=fftshift(fft2(noise));
K=x.*conj(x)./(y1.*conj(y1));%����Kֵ  
w=(f.*conj(f))'.*h./(f.*(f.*conj(f)+K'))'; 
weina=abs(ifft2(w)); 
subplot(1,2,2);
imshow(weina,[]);
title('ά���˲��Ľ��');
