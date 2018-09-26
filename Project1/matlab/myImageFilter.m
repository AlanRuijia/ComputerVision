function [img1] = myImageFilter(img0, h)
    % This function operates the same as imfilter(img0, flipped_h, 'replicate')
    
    [m, n] = size(h);
    flipped_h = rot90(h, 2);

    padded_img = padarray(img0, [floor(m/2), floor(n/2)], 'replicate', 'both');
    
    [ism, isn] = size(img0);
    img1 = zeros(ism, isn);
    
    for i = 1:ism
        for j = 1:isn
            pip = padded_img(i : i+m-1, j : j+n-1);
            sa =  pip .* flipped_h;
            img1(i, j) = sum(sum(sa)); 
        end
    end
end
