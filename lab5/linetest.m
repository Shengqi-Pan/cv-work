z = zeros(100, 200);
z = z + 1; 
z(50, 1:200) = 256;
img = z;
img = double(img);
%kernel = [-1, -1, -1; 2, 2, 2; -1, -1, -1];
kernel = [-1, 2, -1; -1, 2, -1; -1, 2, -1];
imgout = convolve(img, kernel);

subplot(2, 1, 1);
imshow(uint8(img));
title('Ô­Í¼');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('¼ì²âºóµÄÍ¼');