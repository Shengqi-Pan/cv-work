% �Ҷ���ֵ�ָ�
img = imread('./fruit.png');
img = rgb2gray(img);

% ��ʾԭͼ��
subplot(2, 1, 1);
imshow(img);
title('ԭͼ��');

Th = 205;  % �趨��ֵ
imgout = img;
imgout(imgout < Th) = 1;
imgout(imgout > Th) = 256;


% ��ʾ�任���ͼ��
subplot(2, 1, 2);
imshow(imgout);
title('��ֵ�Ҷȷָ���ͼ��');