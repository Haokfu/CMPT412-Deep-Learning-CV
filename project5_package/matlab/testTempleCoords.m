% A test script using templeCoords.mat
%
% Write your code here
%
clear all;
%load images
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

%load .mat
load ../data/someCorresp.mat;

F = eightpoint(pts1, pts2, M);
load ../data/templeCoords.mat;

pts2 = epipolarCorrespondence(im1,im2,F,pts1);

load ../data/intrinsics.mat;
E = essentialMatrix(F,K1,K2);

extrinsic2 = camera2(E);
extrinsic1 = [1,0,0,0;0,1,0,0;0,0,1,0];
P1 = K1 * extrinsic1;
max_depth = -1;
real_P2 = zeros(3,4);
final_index = 0;
final_pts3d = zeros(size(pts1,1),3);
for i = 1:4
    P2 = K2 * extrinsic2(:,:,i);
    pts3d = mytriangulate(P1,pts1,P2,pts2);
    depth = sum(pts3d(:,3)>0);
    if depth > max_depth
        final_pts3d = pts3d;
        max_depth = depth;
        real_P2 = P2;
        final_index = i;
    end

end

final_extrinsic = extrinsic2(:,:,final_index);
R1 = [1,0,0;0,1,0;0,0,1];
t1 = [0;0;0];
R2 = final_extrinsic(:,1:3);
t2 = final_extrinsic(:,4);

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

plot3(final_pts3d(:,1),final_pts3d(:,3),-final_pts3d(:,2),'.');
axis equal
