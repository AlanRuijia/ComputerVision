% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
clear all;
close all;

cv_img = imread('../data/cv_cover.jpg');

%% Compute the features and descriptors
hist = zeros(1,35);
for i = 1:35
    %% Rotate image
    cv_img_rot = imrotate(cv_img, i*10, 'bilinear', 'crop');
    %% Compute features and descriptors
    [locs1, locs2] = matchPics(cv_img, cv_img_rot);
    %% Match features
    hist(i) = size(locs1, 1);
    %% Update histogram
end

%% Display histogram
bar(hist);