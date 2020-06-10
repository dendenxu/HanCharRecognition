function preprocessAll(directory)
    narginchk(1, 1);

    if ~isa(directory, 'char')
        error("Please make sure you've inputted a char(with a pair of single quotation marks)");
    end

    mkdir(['.\\', 'preprocessed\\', directory]);
    fileList = dir(directory);
    fileName = [];

    for i = 3:size(fileList, 1)

        if fileList(i).isdir
            preprocessAll([directory, '\\', fileList(i).name]);

        else
            fileName = [fileName, string(fileList(i).name)];
        end

    end

    for i = 1:size(fileName, 2)
        img = preprocess(imread(['.\\', directory, '\\', char(fileName(i))]));
        imwrite(img, fullfile('.\preprocessed\', directory, [char(string(i)), '.jpg']));
    end
