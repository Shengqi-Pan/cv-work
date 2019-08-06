%%%迭代式阈值选择（二值分割）
img = imread('dog.png');
img = rgb2gray(img);
Th = mean(img( : ));            %将灰度均值设为初始阈值
newTh = 0;
i = 1;
while (Th - newTh) > 1
    pic1 = img;
    pic1(pic1 > Th) = 0;            %大于阈值置零方便求均值
    miu1 = mean(pic1(:));        %小于阈值的像素的灰度均值
    pic2 = img;
    pic2(pic2 < Th) = 0;            %小于阈值置零方便求均值 
    miu2 = mean(pic2( : ));      %大于阈值的像素的灰度均值
    if i ~= 1
        Th = newTh; 
    end
    i = i + 1;
    newTh = (miu1 + miu2) / 2;
end
imgout = img;
imgout(imgout < Th) = 1;
imgout(imgout > Th) = 256;
%%%显示图像
subplot(2, 1, 1);
imshow(img);
title('原图像');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('迭代阈值法图像');