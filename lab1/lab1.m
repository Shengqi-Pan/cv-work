% ƽ�Ʊ任
img = imread('test_image.jpg');
 
subplot(3, 1, 1);
imshow(img - 100);
title('d = -100');
 
subplot(3, 1, 2);
imshow(img);
title('ԭͼ��');
 
subplot(3, 1, 3);
imshow(img + 100);
title('d = 100');