function [wordMap] = getVisualWords(I, filterBank, dictionary)
    img = im2double(I);
    H = size(img, 1);
    W = size(img, 2);
    [L, a, b] = RGB2Lab(img(:, :, 1), img(:, :, 2), img(:, :, 3));
    Im = cat(3, L, a, b);
    filterResponses = extractFilterResponses(Im, filterBank); % H * W * 60
    filterResponses = reshape(filterResponses, [], 3*size(filterBank, 1));
    [~, wordMap] = pdist2(dictionary, filterResponses, 'euclidean','Smallest',1); 
    wordMap = reshape(wordMap, H, W);
end