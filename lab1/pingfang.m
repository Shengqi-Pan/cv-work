% ƽ���任
img = imread('haze.jpg');
img = double(img);
imgout = img .^ 2 / 256;

%��ʾԭͼ��
subplot(2, 1, 1);
imshow(uint8(img));
title('ԭͼ��');

%��ʾ�任���ͼ��
subplot(2, 1, 2);
imshow(uint8(imgout));
title('ƽ���任���ͼ��');