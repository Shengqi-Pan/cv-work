%%%%阈值平滑%%%%
img = imread('test.png');
img = rgb2gray(img);
img = double(img);
[row, col] = size(img);     %确定图像大小
imgAvg = sum(sum(img)) / (row * col);   %求均值

subplot(2,1,1);
imshow(uint8(img));
title('原图像');
subplot(2,1,2);
imgTh = pinghuaTh(img, 20, 3);
imshow(uint8(imgTh));
title('阈值平滑后的图像');
for Th = 0 : 10 : 20
    for window = 3 : 2 : 7
        imgTh = pinghuaTh(img, Th, window);
        i = ((window - 1) / 2 - 1) * 3 + Th / 10 + 1;%当前是第i张图
        subplot(3,3,i);
        imshow(uint8(imgTh));
        title(['Th = ', num2str(Th), ' window = ', num2str(window)]);
    end
end

%%%%实现阈值平滑
%%%%函数的第一个参数为图像，第二个参数为阈值，第三个参数为窗口大小
function imgTh = pinghuaTh(img, Th, window)
    imgTh = img;
    [row, col] = size(imgTh); 
    for i = (window - 1)/2 + 1 : (col - (window - 1)/2)%遍历列数
        for j = (window - 1)/2 + 1 : (row - (window - 1)/2)%遍历行数
            imgThAvg = sum(reshape(imgTh(j - (window - 1) / 2 : j + (window - 1) / 2, i - (window - 1)/2 : i + (window - 1)/2), [1,window * window])) / (window * window);
            if abs(imgTh(j, i) - imgThAvg) > Th
                imgTh(j, i) = imgThAvg;
            end
        end
    end
end
%%%%实现空域低通滤波