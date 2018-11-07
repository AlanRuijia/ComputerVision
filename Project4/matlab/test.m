clear all;
close all;
im = im2double(imread('../data/campus/sun_abslhphpiejdjmpz.jpg'));
% im = im2double(imread('../data/campus/sun_dylabfyfkiigefwx.jpg'));
% im = im2double(imread('../data/campus/sun_dxyvddkvgmbvjyaa.jpg'));
% im = im2double(imread('../data/bedroom/sun_bgfjnyewrxozjnet.jpg'));
% im = im2double(imread('../data/bedroom/sun_azzcwowmmtgroxaq.jpg'));
% im = im2double(imread('../data/bedroom/sun_azscohlnxentjzfz.jpg'));


filterBank = createFilterBank();

% % Q2.1 Q2.2
load('./dictionaryRandom.mat', 'dictionaryRandom');
load('./dictionaryHarris.mat', 'dictionaryHarris');
wordMap = getVisualWords(im, filterBank, dictionaryRandom);

subplot(1,3,1);
imshow(im);
title('original image');
subplot(1,3,2);
imshow(label2rgb(wordMap));
title('random');
wordMap = getVisualWords(im, filterBank, dictionaryHarris);
subplot(1,3,3);
imshow(label2rgb(wordMap));
title('harris');
h = getImageFeatures(wordMap, size(dictionaryHarris,1));
figure;
bar(1:100, h);

% % Q1.2
% points1 = getRandomPoints(im, 500);
% points2 = getHarrisPoints(im, 500, 0.05);
% figure;
% subplot(1,2,1)
% imshow(im)
% hold on
% plot(points1(:, 1), points1(:, 2), 'r.');
% hold off
% subplot(1,2,2)
% imshow(im)
% hold on
% plot(points2(:, 1), points2(:, 2), 'r.');
% hold off

% % Q 1.1
% [L, a, b] = RGB2Lab(im(:, :, 1), im(:, :, 2), im(:, :, 3));
% I = cat(3, L, a, b);
% res = extractFilterResponses(I, filterBank);
% for i = 1:20
%     d = res(:,:,(3*i-2):3*i);
%     m = max(max(max(d)));
%     d = d/m;
%     d = uint8(d * 255);
%     for j = 1:3
%         subplot(1,3,j);
%         imshow(d(:,:,j));
%     end
%     pause;
% end
