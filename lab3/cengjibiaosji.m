%%%图像的层级表示
img = imread('hasaki.png');
img = rgb2gray(img);
[row, col] = size(img);       %确定图像大小
imgsize = row;                %imgsizes是压缩后的大小
lastimage = double(img);              %初始化lastimage
%显示原图
subplot(2, 5, 1);
imshow(img);
title('原图');

i = 1;
while imgsize ~= 1
    imgsize = imgsize/2;
    imgout = zeros(imgsize, imgsize);   %初始化输出图像
    for j = 1 : imgsize                %给压缩后的图像幅值
        for k = 1 : imgsize
            former_j = 2 * j - 1;       %压缩后下标j所对应压缩前的下标
            former_k = 2 * k - 1;       %压缩后下标k所对应压缩前的下标
            imgout(j, k) = (lastimage(former_j, former_k) + ...
                            lastimage(former_j + 1, former_k) + ...
                            lastimage(former_j, former_k + 1) + ...
                            lastimage(former_j + 1, former_k + 1)) / 4;
        end
    end
    subplot(2, 5, i + 1);
    imshow(uint8(imgout));
    title(['第', num2str(i), '次处理']);

    i = i + 1;
    lastimage = imgout;
    lastsize = imgsize;
end
