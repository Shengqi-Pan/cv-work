%%%%�������%%%%
img = imread('test.png');
img = rgb2gray(img);
img = double(img);
kernel = [-1, 0, 1; -2, 0 ,2; -1, 0, 1];%��������
kernel = [-2, -4, -4, -4, -2; ...
          -4, 0, 8, 0, -4; ...
          -4, 8, 24, 8 ,-4; ...
          -4, 0, 8 ,0, -4; ...
          -2, -4, -4, -4, -2];
imgout = convolve(img, kernel);


subplot(2,1,1);
imshow(uint8(img));
title('ԭͼ��');
subplot(2,1,2);
imshow(uint8(imgout));
title('LOG���Ӵ������');