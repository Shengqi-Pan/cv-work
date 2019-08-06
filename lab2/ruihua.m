%%%%�������%%%%
img = imread('test.png');
img = rgb2gray(img);
img = double(img);
kernel1 = [-1, 0, 1; -2, 0 ,2; -1, 0, 1];%Sobel����
kernel2 = kernel1';
imgout1 = convolve(img, kernel1);
imgout2 = convolve(img, kernel2);
imgout = (imgout1.*imgout2).^0.5;


subplot(1,2,1);
imshow(uint8(img));
title('ԭͼ��');
subplot(1,2,2);
imshow(uint8(imgout));
title('Sobel���Ӵ������');