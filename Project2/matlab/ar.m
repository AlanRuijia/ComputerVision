% Q3.3.1
ar_source = loadVid('../data/ar_source.mov');
book = loadVid('../data/book.mov');
cv_img = imread('../data/cv_cover.jpg');
[cvx, cvy] = size(cv_img);
[arx, ary, ~] = size(ar_source(1).cdata) ;

ar_lower = 50;
ar_upper = 315;
ratiox = cvx / (ar_upper - ar_lower);
croppedy = cvy / ratiox;
offsety = int32((ary - croppedy)/2);
res(1:size(book, 2)) = struct('cdata', zeros(size(book(1).cdata), 'uint8'), 'colormap', []);
v = VideoWriter('../data/ar8.avi');
open(v);
for i = 1:size(book, 2)
    j = int32(1.0 * i / size(book, 2) * size(ar_source, 2));
    img1 = ar_source(j).cdata(ar_lower:ar_upper, offsety:offsety + croppedy, :);
    img1 = imresize(img1, [cvx, cvy]);
    img2 = book(i).cdata;
    [locs1, locs2] = matchPics(cv_img, img2);
    fprintf('%d/%d\n',i,size(book,2));
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    res(i).cdata = compositeH(bestH2to1, img1, img2);
    writeVideo(v,res(i).cdata);
    
end
% implay(res);
close(v);

