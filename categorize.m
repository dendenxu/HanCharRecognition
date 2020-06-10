function accuracy = categorize(directory)
    % 这是多图归类的用户接口函数，请直接传入文件夹名，例如'test'，如果用户想要检查每个字的相似图片会有哪些，请在下方找到whichIsIt函数，将其第二个参数改为true
    % 然后运行完后你会在每张被检查图片旁边看到一个文件夹，打开你就懂了。
    
    % 每次新建的文件夹存在时MATLAB会报警告，眼花缭乱的警告，关了叭关了叭
    warning('off');
    cntAll = 0;
    cntRight = 0;
    % 和gimmeWhere里面挺类似的递归套路，这里就不再赘述
    traverse(directory);

    function traverse(directory)
        narginchk(1, 1);

        if ~isa(directory, 'char')
            directory = char(directory);
        end

        fileList = dir(directory);
        fileName = [];

        for i = 3:size(fileList, 1)

            if fileList(i).isdir
                traverse([directory, '\\', fileList(i).name]);

            else
                fileName = [fileName, string(fileList(i).name)];
            end

        end

        for i = 1:size(fileName, 2)
            category = whichIsIt(['.\\', directory, '\\', char(fileName(i))], false);
            
            % 新建了一个cate结构用于分别储存某个汉字和它的得分，得分越高说明越像
            cnt = 0;
            for index = 1:size(category, 2)
                isSet = 0;

                for j = 1:cnt

                    if cate(j).word == category(index)
                        cate(j).count = 1 / index^2 + cate(j).count;
                        isSet = 1;
                        break;
                    end

                end

                if ~isSet
                    cnt = cnt + 1;
                    cate(cnt).word = category(index);
                    cate(cnt).count = 1 / index^2;
                end

            end

            [~, indices] = sort([cate.count]);
            word = cate(indices(end)).word;
            % word = category(1); % 这一行，在我的数据集里面，完全可以替代上面的for循环那块代码而不降低识别准确度，都是89%，我只剩呵呵。
            % I've got to say that it's nearly useless
            % to analyse all the ten most similar ones, since the resultant
            % accuracy might even be smaller.

            % please make sure the last but one dir is the character of the image
            % 得到.\backup\数据集\数据集\万\kai\欧阳询_01.gif里面的那个“万”字
            % 翻转数组可以避免无意义的查找工作（当数组很大的时候，翻转数组比调用find快多了（虽然两者的时间复杂度应该都是O(n)（推测）））
            tempdir = fliplr(directory);
            n2 = find(tempdir == '\', 4);
            n3 = n2(3);
            n2 = n2(2);
            character = tempdir(n2 + 1:n3 - 1);
            character = fliplr(character);
            was = character;

            if word == was
                cntRight = cntRight + 1;
            end

            cntAll = cntAll + 1;

            mkdir('./categorized', word);
            % 如果复制的目标文件夹不存在，MATLAB会直接报错并推出，告诉我权限不够，这是不能接受的。
            copyfile(['.\\', directory, '\\', char(fileName(i))], fullfile('./categorized', word));
        end

    end

    accuracy = cntRight / cntAll;
    warning('on');% 别忘了把警告打开

    fprintf('%d image(s) processed.\n%d image(s) correctly recognized.\nAccuracy: %.4f%%\n', cntAll, cntRight, accuracy * 100);
end
