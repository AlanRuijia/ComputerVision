function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
H_template_to_img = H2to1;

%% Create mask of same size as template
mask = 255*ones(size(template));

%% Warp mask by appropriate homography
warp_mask = warpH(mask, H_template_to_img, size(img));

%% Warp template by appropriate homography
warp_template = warpH(template, H_template_to_img, size(img));
%% Use mask to combine the warped template and the image
wg = rgb2gray(warp_mask);
indexes = find(wg > 0);
[subx, suby] = ind2sub(size(wg), indexes);
s = size(subx, 1);
for i = 1:s
    img(subx(i), suby(i), :) = warp_template(subx(i), suby(i), :);
end
composite_img = img;
end