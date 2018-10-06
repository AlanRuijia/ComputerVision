function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
% ox1 = x1;
% ox2 = x2;
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
x1 = x1 - centroid1;
x2 = x2 - centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
n1 = max(vecnorm(x1, 2, 2));
n2 = max(vecnorm(x2, 2, 2));

x1 = x1 / n1 * sqrt(2);
x2 = x2 / n2 * sqrt(2);
%% similarity transform 
T1 = [sqrt(2) / n1, 0, -centroid1(1) * sqrt(2) / n1; 0, sqrt(2) / n1, -centroid1(2) * sqrt(2) / n1; 0, 0, 1];

%% similarity transform 2
T2 = [sqrt(2) / n2, 0, -centroid2(1) * sqrt(2) / n2; 0, sqrt(2) / n2, -centroid2(2) * sqrt(2) / n2; 0, 0, 1];

% temp_x1 = [x1, ones(size(x1, 1), 1)]';
% temp_x1 = T1 * temp_x1;
% temp_x2 = [x2, ones(size(x1, 1), 1)]';
% temp_x2 = T2 * temp_x2;
%% Compute Homography
H = computeH(x1, x2);
%% Denormalization
% temp_x1 = (H * temp_x1);
% temp_x1 = [-(temp_x1(1, :) ./ temp_x1(3,:)); -(temp_x1(2, :) ./ temp_x1(3,:)); ones(1,size(temp_x2,2))]
% temp_x1 = inv(T2)*temp_x1
% temp_x2
H2to1 = inv(T2)* [-1, 0,0; 0, -1, 0; 0,0,1] * H * T1;
