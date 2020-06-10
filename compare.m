function similarity = compare(rect1, rect2)
    narginchk(2, 2);

    factor = (sum(sum(rect1)) + sum(sum(rect2)));
    % 如果不添加factor，下面一行计算的就是巴氏距离，添加上面的factor后是开发者调整后的巴氏距离。
    % factor = 1;
    similarity = sum(sum(sqrt(rect1 .* rect2) / factor));
