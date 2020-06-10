function enco = haarenco(img)

    switch ndims(img)
        case 2
            img = preprocess(img);
            cnt = 1;
            haarenco2(img, 0);
        case 3

            for colour = 1:3
                tempimg(:, :, colour) = preprocess(img(:, :, colour));
                cnt = 1;
                haarenco2(tempimg(:, :, colour), colour);
            end

    end

    function haarenco2(img, colour)

        if cnt == 9
            return
        end

        [r2, c2] = size(img);

%         out = zeros(r2, c2,'uint8');
        out = zeros(r2, c2);
        img = double(img);
        for i = 1:r2

            for j = 1:2:c2
                out(i, (j + 1) / 2) = (img(i, j) + img(i, j + 1)) / 2;
                out(i, (j + 1) / 2 + c2 / 2) = (img(i, j) - img(i, j + 1)) / 2;
            end

        end

        temp = out;
        temp = double(temp);
        for j = 1:c2

            for i = 1:2:r2
                out((i + 1) / 2, j) = (temp(i, j) + temp(i + 1, j)) / 2;
                out((i + 1) / 2 + r2 / 2, j) = (temp(i, j) - temp(i + 1, j)) / 2;
            end

        end

        switch colour
            case 0
                enco(1:r2, 1:c2) = out;
            case 1
                enco(1:r2, 1:c2,1) = out;
            case 2
                enco(1:r2, 1:c2,2) = out;
            case 3
                enco(1:r2, 1:c2,3) = out;
        end

        cnt = cnt + 1;
        haarenco2(out(1:r2 / 2, 1:c2 / 2), colour);
    end

end
