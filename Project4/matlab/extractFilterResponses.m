function [filterResponses] = extractFilterResponses(I, filterBank)
    H = size(I, 1);
    W = size(I, 2);
    filterResponses = zeros(H, W, 3 * size(filterBank, 1));
    for i = 1:size(filterBank)
        filter = cell2mat(filterBank(i));
        filterResponses(:, :, 3*(i-1)+1 : 3*(i-1)+3) = imfilter(I, filter, 'same');
%         fs = size(filter, 1);
%         halfFs = floor(fs/2);
%         for d = 1:3
%             temp = I(:, :, d);
%             filterResponses(:, :, 3*(i-1) + d) = conv2(temp, filter, 'same');
%         end
    end
end