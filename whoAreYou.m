function file = whoAreYou(img)
    rect = rectFeature(preprocess(imread(img)));
    where.where = [];
    where.similarity = [];
    where.which = [];
    where.rect = [];
    cnt = 1;
    traverse('???');
    max = 1;

    for j = 1:cnt - 1

        if (where(j).similarity > where(max).similarity)
            max = j;
        end

    end

    file = [string(where(max).where), string(where(max).which)];

    function traverse(directory)
        narginchk(1, 1);

        if ~isa(directory, 'char')
            error("Please make sure you've inputted a char(with a pair of single quotation marks)");
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
            rect0 = rectFeature(preprocess(imread(['.\\', directory, '\\', char(fileName(i))])));
            where(cnt).rect = rect0;
            where(cnt).similarity = compare(rect, rect0);
            where(cnt).where = fullfile('.\', directory, [char(string(i)), '.jpg']);
            where(cnt).which = directory(end-5);
            cnt = cnt + 1;
        end

    end

end
