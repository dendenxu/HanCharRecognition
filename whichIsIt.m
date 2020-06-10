function category = whichIsIt(img, copy)
    % 单张图片的处理函数。这不是默认的用户接口，如果要调用最好直接使用oneImage
    % 如果非要调用，请保证文件名是：00.gif或者test\\数据集\\数据集\\万\\kai\\始平公造像_01.gif这类的
    % maxnum代表的是提取相似度前几的图片，并且复制来的相似度高的图像会放在输入的文件名的同一目录下
    maxnum = 10;
    load('where.mat', 'where');
    rect = rectFeature(preprocess(imread(img)));
    circ = circFeature(preprocess(imread(img)));
    %     鸡肋……
    %     hist = histFeature(preprocess(imread(img)));

    % 整个for循环做了两件事情：计算相似度并找到相似度前maxnum的maxnum张图片
    maxa = 1:maxnum; % 用于暂存相似度前maxnum图片的位置
    for i = 1:size({where.rect}, 2)

        where(i).rectSimilarity = compare(where(i).rect, rect);
        where(i).circSimilarity = compare(where(i).circ, circ);
        %         真的鸡肋……
        %         where(i).histSimilarity = compare(where(i).hist, hist);
        where(i).similarity = 0.5 * where(i).rectSimilarity + 1.5 * where(i).circSimilarity;
        where(i).similarity = where(i).similarity^30;

        if i > maxnum

            % 对前十个直接调用sort进行排序，开支是常数可忽略
            if i == 11
                [~, maxa] = sort([where(1:maxnum).similarity]);
                maxa = maxa(end:-1:1);
            end

            % 平均比较的次数应该是5次？（没有严格推导）
            for j = maxnum:-1:1

                if where(maxa(j)).similarity > where(i).similarity

                    if j < maxnum
                        maxa(j + 2:maxnum) = maxa(j + 1:maxnum - 1);
                        maxa(j + 1) = i;
                        j = 0;
                    end

                    break;
                end

            end

            % 用于处理第i张图片就是最大值的情况
            if j == 1
                j = 0;
                maxa(j + 2:maxnum) = maxa(j + 1:maxnum - 1);
                maxa(j + 1) = i;
            end

        end

    end

    % 每个if copy内部进行的都是将前十大放到工作目录下某个文件夹的操作。
    category = repmat('', 1, maxnum);
    name = img(1:find(img == '.', 1) - 1);

    % 如果复制的目标文件夹不存在，MATLAB会直接报错并推出，告诉我权限不够，这是不能接受的。
    if copy
        mkdir('./', name);
    end

    for i = 1:maxnum
        category(i) = where(maxa(i)).which;

        % 复制的图像是没有经过preprocess的原图，所以调用whichIsIt并且传入的copy为true时，请保证gimmeWhere的文件夹还在原来的位置，当然传入的copy为false时就不管了
        if copy
            copyfile(where(maxa(i)).where, ['./', name]);
            movefile(['./', name, '/', where(maxa(i)).name], ['./', name, '/', num2str(where(maxa(i)).similarity, '%.6f'), where(maxa(i)).name])
        end

    end

    if copy
        copyfile(img, ['./', name]);
    end
