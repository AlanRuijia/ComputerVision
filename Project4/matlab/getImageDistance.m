function [dist] = getImageDistance(hist1, histSet, method)
    s = size(histSet, 1);
    hist = repmat(hist1, s, 1);
    dist = 0;
    if strcmp(method, 'euclidean')
        dist = sqrt(sum((hist - histSet).^2, 2));
    elseif strcmp(method, 'chi2')
        dist = 0.5 * sum(fillmissing(((hist - histSet).^2)./(hist+histSet), 'constant', 0), 2);
    end
end