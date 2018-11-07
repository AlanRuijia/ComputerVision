% train
clear all;
close all;
load('visionSVM.mat', 'SVMModels');
load('../data/traintest.mat', 'test_imagenames', 'test_labels');
dir = '../data/';
K = 100;
classes = unique(test_labels);
imagepaths = string(test_imagenames);
Xtest = zeros(size(test_imagenames, 2), K);
for i = 1:size(test_imagenames, 2)
    imgP = char(strrep(strcat(dir, imagepaths(i)),'.jpg','.mat'));
    load(imgP, 'wordMap');
    h = getImageFeatures(wordMap, K);
    Xtest(i, :) = h;
end
Scores = zeros(size(test_imagenames, 2), numel(classes));

for j = 1:numel(classes)
    [~,score] = predict(SVMModels{j},Xtest);
    Scores(:,j) = score(:,2); % Second column contains positive-class scores
end

[~,maxScore] = max(Scores,[],2);
accuracy = sum(maxScore' == test_labels)/numel(test_labels)
c = zeros(8);
for i = 1:numel(test_labels)
    c(test_labels(i), maxScore(i)) = c(test_labels(i), maxScore(i)) + 1;
end
c