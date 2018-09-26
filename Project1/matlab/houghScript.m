clear;
close all;

datadir     = '../data';    %the directory containing the images
resultsdir  = '../results'; %the directory for dumping results

%parameters
sigma     = 3;
threshold = 0.1;
rhoRes    = 1;
thetaRes  = pi/180;
nLines    = 150;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));

for i = 1:numel(imglist)
    
% code for experiments
% tpara = [50, 100, 150, 200,250];
% for tpa = 1:size(tpara,2)
%     nLines = tpara(tpa);

    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
    
    %actual Hough line code function calls% 
    [Im] = myEdgeFilter(img, sigma); 
    [H,rhoScale,thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);

    [rhos, thetas] = myHoughLines(H, nLines);

%     % Display points on hough graph
%     HT = imadjust(rescale(H));
%     figure;
%     imshow(HT,[],'XData',thetaScale,'YData',rhoScale,'InitialMagnification','fit');
%     xlabel('\theta'), ylabel('\rho');
%     axis on, axis normal, hold on;
%     plot(thetaScale(thetas(:)),rhoScale(rhos(:)),'s','color','red');

    lines = houghlines(Im>threshold, 180.0*(thetaScale/pi), rhoScale, [rhos,thetas],'FillGap',5,'MinLength',7);

    %everything below here just saves the outputs to files%
%     fname = sprintf('%s/%s_00conv.png', resultsdir, imgname);
%     imwrite(tempIm, fname);
    fname = sprintf('%s/%s_01edge.png', resultsdir, imgname);
    imwrite(sqrt(Im/max(Im(:))), fname);
    fname = sprintf('%s/%s_02threshold.png', resultsdir, imgname);
    imwrite(Im > threshold, fname);
    fname = sprintf('%s/%s_03hough.png', resultsdir, imgname);
    imwrite(H/max(H(:)), fname);
    fname = sprintf('%s/%s_03hough_aug.png', resultsdir, imgname);
    imwrite(imadjust(rescale(H)), fname);
    fname = sprintf('%s/%s_04lines.png', resultsdir, imgname);
     
    img2 = img;
    for j=1:numel(lines)
       img2 = drawLine(img2, lines(j).point1, lines(j).point2); 
    end 
    figure;
    imshow(img2);
    imwrite(img2, fname);

end
    
