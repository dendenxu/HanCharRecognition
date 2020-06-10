>> img00 = preprocess(imread('00.gif'));
>> img01 = preprocess(imread('01.gif'));
>> img10 = preprocess(imread('10.gif'));
>> img11 = preprocess(imread('11.gif'));

>> circ00 = circFeature(img00);
>> circ01 = circFeature(img01);
>> circ10 = circFeature(img10);
>> circ11 = circFeature(img11);

cnt = 0;

for i = 1:10
    isSet = 0;

    for j = 1:cnt

        if cate(j).word == category(i)
            cate(j).cnt = 10 - i + cate(j).cnt;
            isSet = 1;
            break;
        end

    end

    if ~isSet
        cnt = cnt + 1;
        cate(cnt).word = category(i);
        cate(j).cnt = 10 - i + cate(j).cnt;
    end

end

img = imread('rice.png');
[r, c] = size(img);
tic;
total = 0;

for i = 1:4:r

    for j = 1:4:c

        if img(i, j) == 127
            total = total + 1;
        end

    end

end

toc;

tic;
total = size(find(img == 127), 1);
toc;

img = imread('concordaerial.png');
[r, c] = size(img);
tic;
total = 0;

for i = 1:4:r

    for j = 1:4:c

        if img(i, j) == 127
            total = total + 1;
        end

    end

end

toc;

tic;
total = size(find(img == 127), 1);
toc;

a = find(img == 0);
r = rem(a, length);
c = mod(a, length);
rcm = sum(sum(r)) / size(r, 1);
ccm = sum(sum(c)) / size(c, 1);


% 357 image(s) processed.
% 357 image(s) correctly recognized.
% Accuracy: 100.0000%

% 93 image(s) processed.
% 83 image(s) correctly recognized.
% Accuracy: 89.2473%





a = imread('tire.tif');
subplot(131);
imshow(a);
title('原始图像');
x = 1:255;
y = x.*(255-x)/255;
subplot(132);
plot(x,y);
title('函数的曲线图');
b1 = double(a)+0.006*double(a).*(255-double(a));
subplot(133);
imshow(uint8(b1));
title('非线性图像处理结果');


    for i = 1:size({where.rect}, 2)
        if i>10
            if i==11
                [~,maxa] = sort([where(1:10).similarity]);
                maxa = maxa(end:-1:1);
            end
            for j = 10:-1:1
                if where(maxa(j)).similarity>where(i).similarity
                    if j<10
                        maxa(j+2:10) = maxa(j+1:9);
                        maxa(j+1) = i;
                        j=0;
                    end
                    break;
                end
            end
            if j==1
                j=0;
                maxa(j+2:10) = maxa(j+1:9);
                maxa(j+1) = i;
            end
        end
    end