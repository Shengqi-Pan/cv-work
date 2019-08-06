%%%%%%%%%%%%
%直方图显示%
%%%%%%%%%%%%
img = imread('test.png');
img = rgb2gray(img);
[row, col] = size(img);%确定图像大小
hd = zeros(1,256);
for i = 1 : row
   for j = 1 : col
       k = img(i,j);%遍历每一个像素的灰度值
       hd(k) = hd(k) + 1;%hd(k)对应灰度为k的像素的个数
   end
end
%画图
subplot(2,3,1);
imshow(img);
title('原图像');
subplot(2,3,2);
grayscale = 1:256;
bar(grayscale, hd);
title('直方图');

%%%%%%%%%%%%%%%%
%画出累积直方图%
%%%%%%%%%%%%%%%%
leiji = hd;
for i = 2 :256
    leiji(i) = leiji(i) + leiji(i-1);
end
%画图
subplot(2,3,3);
bar(grayscale, leiji);
title('累积直方图');

%%%%%%%%%%%%%%%%%%
%直方图均衡化处理%
%%%%%%%%%%%%%%%%%%
bamp = zeros(1,256);
for i=1:256     
    temp=0;     
    for j=1:i         
        temp=temp+hd(j);     
    end
    bmap(i)=floor(temp*255/(row*col));
end
y=zeros(row,col);

for i=1:row    
    for j=1:col         
        y(i,j)=bmap(img(i,j)+1);     
    end
end
y=uint8(y);
subplot(2,3,4);
imshow(y);
title('直方图均衡化处理结果')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%均衡化后的直方图%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row, col] = size(y);%确定图像大小
hd = zeros(1,256);
for i = 1 : row
   for j = 1 : col
       k = y(i,j);%遍历每一个像素的灰度值
       if k == 0
           k = 1;
       end
       hd(k) = hd(k) + 1;%hd(k)对应灰度为k的像素的个数
   end
end

subplot(2,3,5);
bar(grayscale, hd);
title('均衡化后的直方图');

%%%%%%%%%%%%%%%%%%%%%%%%%%
%画出均衡化后的累积直方图%
%%%%%%%%%%%%%%%%%%%%%%%%%%
leiji = hd;
for i = 2 :256
    leiji(i) = leiji(i) + leiji(i-1);
end
%画图
subplot(2,3,6);
bar(grayscale, leiji);
title('均衡化后的累积直方图');