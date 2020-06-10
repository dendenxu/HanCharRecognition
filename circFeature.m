function feat = circFeature(bw)
    % 扇形特征（极坐标系）提取函数，请传入BW图像矩阵
    length = 256;
    step = 20;
    feat = zeros(4, step);
    rarr = [1, 74, 91, 111, 128];
    thetarr = [0:2 * pi / step:2 * pi, 2 * pi + eps];

    for i = 1:length

        for j = 1:length
            [theta, r] = cart2pol(i - length / 2, j - length / 2);

            if theta < 0
                theta = theta + 2 * pi;
            end

            for k = 1:4

                for l = 1:step

                    if (bw(i, j))

                        if rarr(k) <= r && r < rarr(k + 1) && thetarr(l) <= theta && theta < thetarr(l + 1)
                            feat(k, l) = feat(k, l) + 1;
                        end

                    end

                end

            end

        end

    end
    %     之所以用英文注释：MATLAB一开始不支持font fallback，用等宽英文字体后中文很有可能就是乱码，
    %     后来用VSCode可正常输入中文，最终用Consolas 微软雅黑hybrid字体可在matlab中显示中文。
    %     If you want to uncommend the load pol.mat part of code, you have to
    %     copy the following code to your command window and execute it.
    %     This will create a cart2pol matrix for future use.
    %     x = repmat(1:256, 256, 1);
    %     y = repmat((1:256)', 1, 256);
    %     [theta, r] = cart2pol(x - 128, y - 128);
    %     theta(theta < 0) = theta(theta < 0) + 2 * pi;
    %     save pol.mat


    %     直接通过坐标变换后的矩阵计算，省去了嵌套四级for循环的必要，其中的pol.mat需要执行一次上方的脚本得到。
    %     load pol.mat
    %     for k = 1:4
    %
    %         for l = 1:step
    %
    %             a = find(rarr(k) <= r & r < rarr(k + 1));
    %             b = find(thetarr(l) <= theta & theta < thetarr(l + 1));
    %             e = intersect(a, b);
    %             row = mod(e, length);
    %             col = ceil(e/length);
    %             feat(k, l) = sum(sum(bw(row, col)));
    %
    %         end
    %
    %     end

    %     归一化处理，其实不需要。
    %     feat = feat / (length * length / (4*step));
