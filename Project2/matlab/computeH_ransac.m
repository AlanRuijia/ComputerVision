function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2 )
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
s = size(locs1, 1);
x1 = [locs1, ones(s, 1)]';
x2 = [locs2, ones(s, 1)]';
maxH = zeros(3,3);
maxInliers = [];
count = 0;
for i = 1:200
    indexes = randperm(s);
    indexes = indexes(1:4);
    ps1 = locs1(indexes, :);
    ps2 = locs2(indexes, :);
    H = computeH_norm(ps1, ps2);
    tempx = H*x1;
    tempx = [tempx(1, :)./tempx(3, :); tempx(2, :)./tempx(3, :); tempx(3, :)./tempx(3, :)];
    tempx = sum(abs(x2 - tempx), 1);
    tempinliers = find(tempx < 3);
    tempcount = size(tempinliers, 2);
    if tempcount > count
        maxH = H;
        maxInliers = [indexes, setdiff(tempinliers, indexes)];
        count = tempcount;
    end
end 
fs1 = locs1(maxInliers, :);
fs2 = locs2(maxInliers, :);
inliers = maxInliers;
bestH2to1 = computeH_norm(fs1, fs2);
%Q2.2.3
end

