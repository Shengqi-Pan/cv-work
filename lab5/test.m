clc;
I=imread('test.png');%图片名字
bw=im2bw(I);         %将图像二值化
[r,c]=find(bw==0);  
[rectx,recty,area,perimeter] = minboundrect(c,r,'a'); %'a'是按面积算的最小矩形，如果按边长用'p'。
figure
imshow(bw);
line(rectx(:),recty(:),'color','r');
