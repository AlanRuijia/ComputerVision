clear all;
close all;
load('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');
method = 'chi2';
c = zeros(8);
dir = '../data/';
K = size(dictionary, 1);
load('../data/traintest.mat', 'test_imagenames');
load('../data/traintest.mat', 'test_labels');
imagepaths = string(test_imagenames);
ca = zeros(40,1);
for k = 1:40
    ct = 0;
    k
    for i = 1:size(imagepaths,2)
        imgP = strrep(strcat(dir, char(imagepaths(i))),'.jpg','.mat');
        load(imgP, 'wordMap');
        h = getImageFeatures(wordMap, K);
        ds = getImageDistance(h, trainFeatures, method);
        [~, inds] = sort(ds, 'ascend');
        inds = inds(1:k);
        lp = trainLabels(inds);
        lp = mode(lp);
        lt = test_labels(i);
        if (lt == lp)
            ct = ct + 1;
        end
        c(lt, lp) = c(lt, lp) + 1;
    end
    ca(k) = ct/size(imagepaths,2);
end
[v, ind] = max(ca)
figure;
plot(1:40, ca);