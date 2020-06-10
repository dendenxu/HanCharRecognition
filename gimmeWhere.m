function gimmeWhere(directory)
    % 建立数据库：where.mat的函数，这是默认的用户接口之一。请直接传入文件夹名例如'train'
    narginchk(1, 1);

        % 为了避免不必要的麻烦，先把传入的东西变成字符，好直接用中括号和其他字符合并
        if ~isa(directory, 'char')
            directory = char(directory);
        end
    index = 1;
    % 说是遍历，本质是递归，因为递归时候要有局部的静态变量，采取了嵌套函数的策略。
    traverse(directory);
    % 由于是嵌套函数，处理得当的话，where在递归的哪个地方定义都行
    save('where.mat', 'where');

    function traverse(directory)
        
        fileList = dir(directory);
        fileName = [];

        for i = 3:size(fileList, 1)

            if fileList(i).isdir
                traverse([directory, '\\', fileList(i).name]);

            else
                fileName = [fileName, string(fileList(i).name)];
                % 这里MATLAB会抱怨说，每次fileName的大小都要改变，可是我也不知道这个文件夹里有几个文件啊，
                % 当然可以一点点的分块像某些操作系统一样，一开始分20然后分40啥啥的，但我们的数据集比较小，那样做的开发成本会远远大于带来的效率提升
            end

        end

        for i = 1:size(fileName, 2)
            % where的情况和fileName类似，我并不知道究竟会有多少图片，不太方便提前分配内存
            where(index).rect = rectFeature(preprocess(imread(['.\\', directory, '\\', char(fileName(i))])));
            where(index).circ = circFeature(preprocess(imread(['.\\', directory, '\\', char(fileName(i))])));
            % 直方图是鸡肋
            % where(index).hist = histFeature(preprocess(imread(['.\\', directory, '\\', char(fileName(i))])));
            
            % 下面这一小块就是把.\backup\数据集\数据集\万\kai\欧阳询_01.gif里面的那个“万”字提取出来
            % 翻转数组可以避免无意义的查找工作（当数组很大的时候，翻转数组比调用find快多了（虽然两者的时间复杂度应该都是O(n)（推测）））
            % please make sure the last but one dir is the character of the image
            tempdir = fliplr(directory);
            n2 = find(tempdir == '\', 4);
            n3 = n2(3);
            n2 = n2(2);
            character = tempdir(n2 + 1:n3 - 1);
            character = fliplr(character);

            % 解释一下，which放的是哪个汉字，比如万字，where放的是路径，比如.\backup\数据集\数据集\万\kai，name放的是文件名，比如欧阳询_01.gif
            % recr和circ放的分别是矩形分块下的特征矩阵和扇形分块下的特征矩阵
            where(index).which = character;
            where(index).where = ['.\\', directory, '\\', char(fileName(i))];
            where(index).name = char(fileName(i));
            index = index + 1;
        end

    end

end
