function [rhos, thetas] = myHoughLines(H, nLines)

    tH = imdilate(H, strel('square', 5));
    mask = (tH == H);
    H = H .* mask;
    [~, sInd] = sort(H(:), 'descend');
    mInd = sInd(1:nLines);
    s = size(H);
    [rhos, thetas] = ind2sub(s, mInd);
end
        