function [ H2to1 ] = computeH( x1, x2 )
% COMPUTEH Computes the homography between two sets of points
% x2 = H * x1

% x y => x y 1
x1 = [x1, ones(size(x1,1),1)];
x2 = [x2, ones(size(x2,1),1)];

% x y 1 => x y 1 0 0 0 
x1_pz = [x1, zeros(size(x1,1),3)];

% x y 1 0 0 0  => x y 1 0 0 0 
%                 0 0 0 x y 1  
x1_r = repelem(x1_pz, 2, 1);
x1_r(2:2:end,4:6) = x1_r(2:2:end,1:3);
x1_r(2:2:end,1:3) = 0;

x2_r = repelem(x2, 2, 1);
x2_r(1:2:end,1:3) = [x2_r(2:2:end,1), x2_r(2:2:end,1), x2_r(2:2:end,1)];
x2_r(2:2:end,1:3) = [x2_r(2:2:end,2), x2_r(2:2:end,2), x2_r(2:2:end,2)];
temp_x1 = repelem(x1, 2, 1);
x2_r = x2_r .* temp_x1;

A = [x1_r, x2_r];
[~, S, V] = svd(A);
H2to1 = reshape(V(:, end), [3,3])';
end
