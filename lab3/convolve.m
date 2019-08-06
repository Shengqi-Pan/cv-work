%%%卷积函数，传入的第一个参数为输入图像，第二个参数为卷积核
%%%输出卷积结果
%%%对于图像边缘区域不做处理，也就是说输出图像会减小
function imgout = convolve(imgin, kernel)
    [row, col] = size( imgin );
    [~, kernelsize] = size( kernel );
    r = (kernelsize - 1) / 2;
    rowout = row - 2 * r;  %输出图像大小
    colout = col - 2 * r;  %输出图像大小
    if rowout <= 0 || colout <= 0
        return;
    end
    imgout = zeros(rowout, colout);%初始化输出数组
    for i = 1 : rowout
        for j = 1 : colout
            imgout(i, j) =  max(0, sum(sum(imgin(i : i + 2 * r, j : j + 2 * r).*(kernel))));
        end
    end
end