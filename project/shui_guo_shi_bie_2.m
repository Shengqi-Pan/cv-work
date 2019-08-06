%Name: ROI extraction
%Function: Extract ROI in a RGB image
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization
rgbimg = imread('test.jpg');
figure;
imshow(rgbimg);
r = rgbimg(:, :, 1);
g = rgbimg(:, :, 2);
b = rgbimg(:, :, 3);
% imshow(r);
% figure;
% imshow(g);
% figure;
% imshow(b);
% grayimg=rgb2gray(rgbimg);
% imshow(grayimg);
hsvimg = rgb2hsv(rgbimg);
H = hsvimg(:, :, 1);
S = hsvimg(:, :, 2);
V = hsvimg(:, :, 3);
% figure;
% imshow(H);
% title('H');
% figure;
% imshow(S);
% title('S');
% figure;
% imshow(V);
% title('V');



%rgb = imread('pears.png');%读取原图像
I = H;%转化为灰度图像
hy = fspecial('sobel');%sobel算子
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');%滤波求y方向边缘
Ix = imfilter(double(I), hx, 'replicate');%滤波求x方向边缘
gradmag = sqrt(Ix.^2 + Iy.^2);%求摸
%3.分别对前景和背景进行标记：本例中使用形态学重建技术对前景对象进行标记，首先使用开操作，开操作之后可以去掉一些很小的目标。
se = strel('disk', 40);%圆形结构元素
Io = imopen(I, se);%形态学开操作
Ie = imerode(I, se);%对图像进行腐蚀
Iobr = imreconstruct(Ie, I);%形态学重建
Ioc = imclose(Io, se);%形态学关操作
Iobrd = imdilate(Iobr, se);%对图像进行膨胀
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));%形态学重建
Iobrcbr = imcomplement(Iobrcbr);%图像求反
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));%转化为二值图像
bw = imcomplement(bw);%图像求反
figure;
imshow(bw), %显示二值图像
title('Thresholded opening-closing by reconstruction')
bww=im2uint8(bw)/255;
rgbimg(:, :, 1)=bww.*rgbimg(:, :, 1);
rgbimg(:, :, 2)=bww.*rgbimg(:, :, 2);
rgbimg(:, :, 3)=bww.*rgbimg(:, :, 3);
figure;
imshow(rgbimg);
    