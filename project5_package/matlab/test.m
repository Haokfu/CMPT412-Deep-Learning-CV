
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

F = eightpoint(pts1,pts2,M);
displayEpipolarF(im1,im2,F);
% epipolarMatchGUI(im1,im2,F);