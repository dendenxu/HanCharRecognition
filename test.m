function test(directory)

    if ~isa(directory, 'char')
        directory = char(directory);
    end

    fileList = dir(directory);
    fileName = [];

    for i = 3:size(fileList, 1)

        if fileList(i).isdir
            test([directory, '\\', fileList(i).name]);

        else
            fileName = [fileName, string(fileList(i).name)];
        end

    end

    if size(fileName, 2) / 2 == 0
        return;
    end

    for i = round(size(fileName, 2) / 4) + 1:size(fileName, 2)
        delete(['.\\', directory, '\\', char(fileName(i))]);

    end

end
