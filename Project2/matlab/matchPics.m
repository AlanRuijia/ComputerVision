function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if (size(I1,3) == 3)
    I1 = rgb2gray(I1);
end
if (size(I2,3) == 3)
    I2 = rgb2gray(I2);
end
%% Detect features in both images
corners1 = detectFASTFeatures(I1);
corners2 = detectFASTFeatures(I2);
% corners1 = detectSURFFeatures(I1);
% corners2 = detectSURFFeatures(I2);
%% Obtain descriptors for the computed feature locations
[desc1, templocs1] = computeBrief(I1, corners1.Location);
[desc2, templocs2] = computeBrief(I2, corners2.Location);
% [desc1, templocs1] = extractFeatures(I1, corners1.Location);
% [desc2, templocs2] = extractFeatures(I2, corners2.Location);
% size(desc1)
%% Match features using the descriptors
% indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', 50, 'MaxRatio', 0.6, 'Unique', true);
indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', 50, 'MaxRatio', 0.75, 'Unique', true);
% size(indexPairs)
locs1 = templocs1(indexPairs(:,1),:);
locs2 = templocs2(indexPairs(:,2),:);

end

