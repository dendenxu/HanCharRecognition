function hist = histFeature(img)
    % 汉字识别中，直方图净帮倒忙，这段代码其实可以删了。
    [r, c] = size(img);
    hist = zeros(1, 2);
    hist(1) = sum(sum(img)) / (r * c);
    hist(2) = 1 - hist(1);
