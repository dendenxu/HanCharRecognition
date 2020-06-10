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


    for i = 1:size(fileName,2)
        name = char(fileName(i));
        if name(end-4)=='1'
            delete(['.\\', directory, '\\', name]);
        end
    end

end
