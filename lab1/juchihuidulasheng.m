img = imread('haze.jpg');
img = rgb2gray(img);
fa0 = floor(min(min(img)));
fb0 = floor(max(max(img)));
gb = 256;
ga = 1;
step = floor((fb0 - fa0) / 4);
[row, col] = size(img);%获取输入图像的尺寸
% imgout = zeros(row, col);%初始化变换后的图像

%显示原图像
subplot(2, 1, 1);
imshow(img);
title('原图像');

imgout = img;
for k = 1 : 4
    fa = fa0 + (k - 1) * step;
    fb = fa + step;
    if i == 4
        fb = fb0;
    end
    for i = 1 : row
        for j = 1 : col
            if imgout(i, j) > fa && imgout(i, j) < fb
                imgout(i, j) = ((gb - ga)/(fb - fa))*(img(i, j) - fa) + ga;
            end
        end
    end
end
%显示变换后的图像
subplot(2, 1, 2);
imshow(uint8(imgout));
title('锯齿灰度拉伸后的图像');