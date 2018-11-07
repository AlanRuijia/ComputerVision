function [ h ] = getImageFeatures(wordMap, dictionarySize)
h = zeros(dictionarySize, 1);
for i = 1:dictionarySize
    c = sum(wordMap(:) == i);
    h(i) = c;
end
m = max(h);
h = (h/m)';
end
