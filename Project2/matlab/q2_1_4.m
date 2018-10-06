%Q2.1.4
close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');


% [locs1, locs2] = matchPics(cv_cover, cv_desk);
% value gained when MaxRatio = 0.6 in matchPics
locs1=[229, 64;
   221,   320;
   264,   346;
   279,   386;
   330,   398;
   ];
locs2 =[429,   217;
   414,   373;
   463,   394;
   486,   430;
   548,   440;] ;


figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2, 'montage');
title('Showing all matches');

% Visualize computeH and computeH_norm
% H = computeH(locs1, locs2);
H = computeH_norm(locs1, locs2);
l = min([size(cv_cover,1), size(cv_cover,2), size(cv_desk,1), size(cv_desk,2)]);
test_size = 10;
input_points = randi([1, l], test_size, 2);

test_points = double([input_points, ones(test_size,1)]');
generated_points = (H*test_points)';
res_points = abs([generated_points(:, 1)./generated_points(:, 3), generated_points(:, 2)./generated_points(:, 3)]);
figure;
showMatchedFeatures(cv_cover, cv_desk, input_points, res_points, 'montage');

% Visualize computeH_ransac
[locs1, locs2] = matchPics(cv_cover, cv_desk);
[H, Inliers] = computeH_ransac(locs1, locs2);
l = min([size(cv_cover,1), size(cv_cover,2), size(cv_desk,1), size(cv_desk,2)]);
test_size = 10;
input_points = randi([1, l], test_size, 2);

test_points = double([input_points, ones(test_size,1)]');
generated_points = (H*test_points)';
res_points = abs([generated_points(:, 1)./generated_points(:, 3), generated_points(:, 2)./generated_points(:, 3)]);
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1(Inliers, :), locs2(Inliers, :), 'montage');
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1(Inliers(1:4), :), locs2(Inliers(1:4), :), 'montage');
