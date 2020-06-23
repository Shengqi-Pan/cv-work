% Æ½ÒÆ±ä»»
img = imread('test_image.jpg');
 
subplot(3, 1, 1);
imshow(img - 100);
title('d = -100');
 
subplot(3, 1, 2);
imshow(img);
title('Ô­Í¼Ïñ');
 
subplot(3, 1, 3);
imshow(img + 100);
title('d = 100');