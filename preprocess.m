function out = preprocess(img)
    % 预处理图像的函数，请传入图像矩阵。
    narginchk(1, 1);
    wanted = [256, 256];% 开发人员的选择，可以修改

    % 用switch case + nested function 形式处理可能的输入（RGB或灰度或二值）
    switch ndims(img)
        case 2

            if (find(img > 1, 1))
                img = imbinarize(img, 'global');
            end

        case 3
            img = imbinarize(rgb2gray(img), 'global');
    end
    
    % 大小变换
    if ~isequal(wanted, size(img))
        img = imresize(img, wanted);
    end

    if ~img(1,1)
        img = ~img;
    end


    % 重心查找
    [r, c] = size(img);
    [rcm, ccm] = cm(img);

    function [rcm, ccm] = cm(img)
        rcm = 0;
        ccm = 0;
        cnt = 0;

        for i = 1:4:r

            for j = 1:4:c

                if ~img(i, j)
                    rcm = rcm + i;
                    ccm = ccm + j;
                    cnt = cnt + 1;
                end

            end

        end

        rcm = round(rcm / cnt);
        ccm = round(ccm / cnt);
        % 可用find函数代替上部分代码
        % a = find(img == 0);
        % rarr = mod(a, wanted(1));
        % carr = floor(a / wanted(1));
        % rcm = round(sum(sum(rarr)) / size(rarr, 1));
        % ccm = round(sum(sum(carr)) / size(carr, 1));
    end

    % 图片平移
    out = zeros(wanted, 'logical');
    out = out + 1;
    dx = double(wanted(1) / 2) - double(rcm);
    dy = double(wanted(2) / 2) - double(ccm);

    if dx >= 0

        if dy >= 0
            out(dx + 1:r, dy + 1:c) = img(1:r - dx, 1:c - dy);
        else
            out(dx + 1:r, 1:c + dy) = img(1:r - dx, -dy + 1:c);
        end

    else

        if dy >= 0
            out(1:r + dx, dy + 1:c) = img(-dx + 1:r, 1:c - dy);
        else
            out(1:r + dx, 1:c + dy) = img(-dx + 1:r, -dy + 1:c);
        end

    end
    % 可增加边缘查找功能
    % out = ~edge(out,'canny');
    out = logical(out);
end
