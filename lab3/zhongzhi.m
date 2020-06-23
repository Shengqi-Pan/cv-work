%%%中值处理
img = imread('./source/zaosheng.png');
img = rgb2gray(img);
[row, col] = size(img);%确定图像大小
window = 3;
result = zeros(row-(window-1), col-(window-1));
for i = 2:(col - (window - 1)/2)%遍历列数
    for j = 2:(row - (window - 1)/2)%遍历行数
        result(j-1,i-1) = min(reshape(img(j-1:j+1, i-1:i+1), [1,9]));
    end
end
subplot(2,1,1)
imshow(img);
title('原图像');
subplot(2,1,2)
imshow(uint8(result));
title('中值滤波图像');