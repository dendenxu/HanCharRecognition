function train(directory)

    if ~isa(directory, 'char')
        directory = char(directory);
    end

    fileList = dir(directory);
    fileName = [];

    for i = 3:size(fileList, 1)

        if fileList(i).isdir
            train([directory, '\\', fileList(i).name]);

        else
            fileName = [fileName, string(fileList(i).name)];
        end

    end

    if size(fileName, 2) / 2 == 0
        return;
    end

    for i = 1:round(size(fileName, 2) / 4)
        delete(['.\\', directory, '\\', char(fileName(i))]);

    end

end
