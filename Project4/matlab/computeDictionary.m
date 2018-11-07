t = load('../data/traintest.mat');
imgPaths = t.all_imagenames;
dictionaryRandom = getDictionary(imgPaths, 1500, 100, 'random');
save('./dictionaryRandom.mat', 'dictionaryRandom');
dictionaryHarris = getDictionary(imgPaths, 1500, 100, 'harris');
save('./dictionaryHarris.mat', 'dictionaryHarris');
