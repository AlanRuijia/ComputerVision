function [img1] = myEdgeFilter(img0, sigma)
    % Smooth the image using gaussian filter
    gaussian_filter = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
    sm_img = myImageFilter(img0, gaussian_filter);

    xs = fspecial('sobel')';
    imgx = myImageFilter(sm_img, xs);
    ys = fspecial('sobel');
    imgy = myImageFilter(sm_img, ys);
    
    imgm = sqrt(imgx.*imgx + imgy.*imgy); 
    angle = atan2(imgy, imgx);
    
    img1 = myNonMaxSup(imgm, angle);

end
    
                
        
        
