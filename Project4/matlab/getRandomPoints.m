function [points] = getRandomPoints(I, alpha)
    h = size(I, 1);
    w = size(I, 2);
    s = [h, w];
    A = rand(s);
    inds = randperm(numel(A), alpha);  
    [pointsx, pointsy] = ind2sub(s, inds);      
    points = [pointsy(:), pointsx(:)];
end