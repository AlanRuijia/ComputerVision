function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    imagepaths = string(imgPaths);
    dir = '../data/';
    filterBank = createFilterBank();
    T = size(imagepaths,2);
    n = size(filterBank, 1);
    pixelResponses = zeros(alpha*T, 3*n);
    for i = 1:T
        imgP = char(strcat(dir, imagepaths(i)));
        img = imread(imgP);
        if (size(img,3) == 1)
            img = cat(3, img, img, img);
        end
        img = im2double(img);
        [L, a, b] = RGB2Lab(img(:, :, 1), img(:, :, 2), img(:, :, 3));
        I = cat(3, L, a, b);
        filterResponses = extractFilterResponses(I, filterBank);
        if (strcmp(method, 'random'))
            points = getRandomPoints(I, alpha);
        elseif (strcmp(method, 'harris'))
            points = getHarrisPoints(img, alpha, 0.04);
        end
        for j = 1:alpha
            pixelResponses(alpha*(i-1)+j, :) = filterResponses(points(j,2), points(j, 1), :);
        end
        if (mod(i, 100) == 91)
            i
        end
    end
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end