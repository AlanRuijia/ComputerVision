function F1to2 = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
    pts1 = pts1/M;
    pts2 = pts2/M;
    x1 = [pts1, ones(size(pts1, 1), 1)];
    x2 = [pts2, ones(size(pts2, 1), 1)];
    A = kron(x1, [1,1,1]) .* [x2, x2, x2];
    [~, ~, V] = svd(A);
    F = reshape(V(:, end), [3,3])';
    [U, S, Vt] = svd(F);
    S(3,3) = 0;
    F1to2 = U * S * (Vt');
    F1to2 = refineF(F1to2, pts1, pts2);
    mask = [1/M, 0, 0; 0, 1/M, 0; 0, 0, 1];
    F1to2 = mask * F1to2 * mask;
end