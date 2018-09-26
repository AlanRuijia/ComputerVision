function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
    Im = Im';
    [w, h] = size(Im);
    maxRho = ceil(norm([w, h])/rhoRes);
    rhoNum = maxRho + 1; 
    thetaNum = 2.0*pi / thetaRes;
    
    i = 1:thetaNum;
    thetaScale = (thetaRes * (i-1));

    rhoScale = (0:rhoRes:(rhoRes*maxRho));
    rhoBin = [rhoScale - 0.5*rhoRes, rhoRes*maxRho + 0.5*rhoRes];

    pInd = find(Im > threshold);
    s = size(Im);
    [pSubx, pSuby] = ind2sub(s, pInd);
    
    pSubx = pSubx - 1;
    pSuby = pSuby - 1;

    H = zeros([rhoNum, thetaNum]);

    thetax = pSubx * cos(thetaScale); % generate x * t i xit0, xit1, ... , xitn
    thetay = pSuby * sin(thetaScale);
    rho = thetax + thetay;

    for i=1:thetaNum
        H(:,i) = histcounts(rho(:, i), rhoBin)';
    end
 
end
        
        