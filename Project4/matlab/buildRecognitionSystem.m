% type : 1 => visionRandom, 2 => visionHarris, 3 => visionSVM
clear all;
close all;
type = 3;
if type == 1
    load('dictionaryRandom.mat', 'dictionaryRandom');
    dictionary = dictionaryRandom;
elseif type == 2
    load('dictionaryHarris.mat', 'dictionaryHarris');
    dictionary = dictionaryHarris;
elseif type == 3
    load('dictionaryHarris.mat', 'dictionaryHarris');
    dictionary = dictionaryHarris;
end

filterBank = createFilterBank();
load('../data/traintest.mat', 'train_imagenames');
load('../data/traintest.mat', 'train_labels');
imagepaths = string(train_imagenames);
dir = '../data/';
T = size(imagepaths,2);
n = size(filterBank, 1);
K = size(dictionary, 1);
trainFeatures = zeros(T, K);
trainLabels = train_labels;
for i = 1:T
    if type == 1
        imgP = char(strrep(strcat(dir, imagepaths(i)),'.jpg','Rand.mat'));
    else
        imgP = char(strrep(strcat(dir, imagepaths(i)),'.jpg','.mat'));
    end
    load(imgP, 'wordMap');
    h = getImageFeatures(wordMap, K);
    trainFeatures(i, :) = h;
    if (mod(i,100)==99)
        i
    end
end
if type == 1
    save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');
else
    save('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');
end


% SVM 
if type == 3
    SVMModels = cell(8,1);
    classes = unique(trainLabels);
    for j = 1:numel(classes)
        indx = (trainLabels == classes(j)); % Create binary classes for each classifier
        SVMModels{j} = fitcsvm(trainFeatures,indx,'Standardize',true, 'KernelFunction','linear', 'BoxConstraint',1);
    end
    save('../ec/visionSVM.mat', 'SVMModels');
end
