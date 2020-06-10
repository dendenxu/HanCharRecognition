function feat = rectFeature(bw)
    % 矩形（直角坐标系）的特征提取函数，请传入BW图像矩阵（logical）
    % 两个数字8是开发者测试得到的结果
    num1 = 8;
    num2 = 8;
    % feat - 存储特征信息的矩阵
    feat = zeros(num1, num2);

    for i = 1:num1
        for j = 1:num2
            feat(i, j) = sum(sum(bw(i * 256 / num1 - (256 / num1 - 1):i * 256 / num1, j * 256 / num2 - (256 / num2 - 1):j * 256 / num2)));
        end
    end
    % 归一化操作，实际上不需要
    % feat = feat / (256 * 256 / (num1 * num2));
