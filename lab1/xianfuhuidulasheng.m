% 限幅灰度拉伸
img = imread('./haze.jpg');
img = rgb2gray(img);
fa = floor(min(min(img)) + 10);
fb = floor(max(max(img)) - 10);
gb = 256;
ga = 1;
[row, col] = size(img);%获取输入图像的尺寸
% imgout = zeros(row, col);%初始化变换后的图像

%显示原图像
subplot(2, 1, 1);
imshow(img);
title('原图像');

imgout = img;
imgout(imgout > fb) = 1;
imgout(imgout < fa) = 256;
for i = 1 : row
    for j = 1 : col
        if imgout(i, j) > fa && imgout(i, j) < fb
            imgout(i, j) = ((gb - ga)/(fb - fa))*(img(i, j) - fa) + ga;
        end
    end
end

%显示变换后的图像
subplot(2, 1, 2);
imshow(uint8(imgout));
title('灰度限幅拉伸后的图像');