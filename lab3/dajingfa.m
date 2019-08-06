%%%大津法（二值分割）
img = imread('fruit.png');
img = rgb2gray(img);
bestg_k = 0;
bestTh = mean(img( : ));        %设定灰度均值为初始阈值
for Th = 1 : 256
    %小于阈值的参数
    pic1 = img;
    pic1(pic1 > Th) = 0;
    miu1 = mean(pic1( : ));
    n1 = sum(sum(pic1 ~= 0));
    %大于阈值的参数
    pic2 = img;
    pic2(pic2 < Th) = 0;
    miu2 = mean(pic2( : ));
    n2 = sum(sum(pic2 ~= 0));
    %计算间类方差
    g_k = n1 * n2 * (miu1 - miu2) ^ 2;
    %当取到目前对大的阈值时，更新最佳阈值
    if g_k > bestg_k
        bestTh = Th;
        bestg_k = g_k;
    end
end
imgout = img;
imgout(imgout < bestTh) = 1;
imgout(imgout > bestTh) = 256;
%%%显示图像
subplot(2, 1, 1);
imshow(img);
title('原图像');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('大津法图像');