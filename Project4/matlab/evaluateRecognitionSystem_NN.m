clear all;
close all;
load('../data/traintest.mat', 'test_imagenames', 'test_labels', 'train_labels');
imagepaths = string(test_imagenames);
dir = '../data/';
for i = 1:2
    for j = 1:2
        if i == 1
            load('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');
            'Harris'
        else
            load('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');
            'Random'
        end
        K = size(dictionary, 1);
        if j == 1
            method = 'euclidean'
        else 
            method = 'chi2'
        end
        c = zeros(8);
        ct = 0;
        for k = 1:size(imagepaths,2)
            if i == 1
                imgP = char(strrep(strcat(dir, imagepaths(k)),'.jpg','.mat'));
            elseif i == 2
                imgP = char(strrep(strcat(dir, imagepaths(k)),'.jpg','Rand.mat'));
            end
            load(imgP, 'wordMap');
            h = getImageFeatures(wordMap, K);
            ds = getImageDistance(h, trainFeatures, method);
            [~, ind] = min(ds);
            lp = trainLabels(ind);
            lt = test_labels(k);
            if (lt == lp)
                ct = ct + 1;
            end
            c(lt, lp) = c(lt, lp) + 1;
        end
        ct/size(imagepaths,2)
        c
    end
end