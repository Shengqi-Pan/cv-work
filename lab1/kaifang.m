img = imread('haze.jpg');
img = double(img);
imgout = sqrt(img) / 16 .* 255;

%��ʾԭͼ��
subplot(2, 1, 1);
imshow(uint8(img));
title('ԭͼ��');

%��ʾ�任���ͼ��
subplot(2, 1, 2);
imshow(uint8(imgout));
title('�����任���ͼ��');