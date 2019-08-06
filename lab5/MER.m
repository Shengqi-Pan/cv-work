%%%Ѱ��ͼ����С��Ӿ���

%%%���õ���ʽ��ֵ�󷨽�ͼ���Ϊ��ֵͼ
img = imread('test0.png');
img = rgb2gray(img);
Th = mean(img( : ));            %���ҶȾ�ֵ��Ϊ��ʼ��ֵ
newTh = 0;
i = 1;
while (Th - newTh) > 1
    pic1 = img;
    pic1(pic1 > Th) = 0;            %������ֵ���㷽�����ֵ
    miu1 = mean(pic1(:));        %С����ֵ�����صĻҶȾ�ֵ
    pic2 = img;
    pic2(pic2 < Th) = 0;            %С����ֵ���㷽�����ֵ 
    miu2 = mean(pic2( : ));      %������ֵ�����صĻҶȾ�ֵ
    if i ~= 1
        Th = newTh; 
    end
    i = i + 1;
    newTh = (miu1 + miu2) / 2;
end
imgTh = img;
imgTh(imgTh < Th) = 1;
imgTh(imgTh > Th) = 256;
imgTh = 256 - imgTh;
%%%���õ���ʽ��ֵ�󷨽�ͼ���Ϊ��ֵͼ
%%%��תͼ������MER
for angle = 0 : 1 : 90
    imgRotated = double(imrotate(imgTh,angle,'bicubic','loose'));  %����ת���ͼ��
    %imshow(uint8(imgRotated));
    [row, col] = size(imgRotated);

    %%%�ж���С��Ӿ��εı߽�
    for i = 1 : row
        if sum(imgRotated(i, :)) > col
            break;
        end
    end
    yMinTest = i;

    for i = row : -1 : 1
        if sum(imgRotated(i, :)) > col
            break;
        end
    end
    yMaxTest = i;

    for i = 1 : col
        if sum(imgRotated(:, i)) > row
            break;
        end
    end
    xMinTest = i;

    for i = col : -1 : 1
        if sum(imgRotated(:, i)) > row
            break;
        end
    end
    xMaxTest = i;
    %%%�ж���С��Ӿ��εı߽�
    
    %%%�������
    XLU = xMinTest * cosd(angle) - yMinTest * sind(angle);
    YLU = xMinTest * sind(angle) + yMinTest * cosd(angle);

    XLD = xMinTest * cosd(angle) - yMaxTest * sind(angle);
    YLD = xMinTest * sind(angle) + yMaxTest * cosd(angle);

    XRU = xMaxTest * cosd(angle) - yMinTest * sind(angle);
    YRU = xMaxTest * sind(angle) + yMinTest * cosd(angle);

    XRD = xMaxTest * cosd(angle) - yMaxTest * sind(angle);
    YRD = xMaxTest * sind(angle) + yMaxTest * cosd(angle);
        
    l1 = sqrt((XLU - XRU) ^ 2 + (YLU - YRU) ^ 2);
    l2 = sqrt((XLU - XLD) ^ 2 + (YLU - YLD) ^ 2);


    nowSize = l1 * l2;
    %%%���浱ǰ��õ�MER
    if angle == 0 || nowSize < typicalSize
        xMin = xMinTest;
        yMin = yMinTest;
        xMax = xMaxTest;
        yMax = yMaxTest;
        typicalSize = nowSize;
        typicalAngle = angle;
        typicalImg = imgRotated;
    end
    %%%���浱ǰ��õ�MER
    lastSize = nowSize;
end

%%%����
XLU = xMin * cosd(typicalAngle) - yMin * sind(typicalAngle);
YLU = xMin * sind(typicalAngle) + yMin * cosd(typicalAngle);

XLD = xMin * cosd(typicalAngle) - yMax * sind(typicalAngle);
YLD = xMin * sind(typicalAngle) + yMax * cosd(typicalAngle);

XRU = xMax * cosd(typicalAngle) - yMin * sind(typicalAngle);
YRU = xMax * sind(typicalAngle) + yMin * cosd(typicalAngle);

XRD = xMax * cosd(typicalAngle) - yMax * sind(typicalAngle);
YRD = xMax * sind(typicalAngle) + yMax * cosd(typicalAngle);
%%%����

subplot(2,1,1);
imshow(uint8(imgTh));
title('ԭͼ��');

out1 = imrotate(imgTh,typicalAngle,'bicubic','loose');
rectx = [xMin, xMax, xMax, xMin, xMin];
recty = [yMax, yMax, yMin, yMin, yMax];
subplot(2,1,2);
imshow(out1);
title(['��ת�Ƕ�Ϊ',num2str(typicalAngle),'��']);
line(rectx(:),recty(:),'color','r');

% out2 = imrotate(Figure1,-typicalAngle,'bicubic','loose');
% imshow(out2);
% rectx = [XLU, XLD, XRD, XRU, XLU];
% recty = [YLU, YLD, YRD, YRU, YLU];
% imshow(uint8(imgTh));
% line(rectx(:),recty(:),'color','r');
%%%��תͼ������MER
