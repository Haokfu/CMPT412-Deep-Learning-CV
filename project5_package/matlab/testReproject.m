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

nop = size(final_pts3d,1);
error_1 = zeros(1,nop);
error_2 = zeros(1,nop);
for i = 1:nop
    p3 = final_pts3d(i,:);
    p3_h = [p3,1]';
    proj_pts1 = P1 * p3_h;
    proj_pts2 = real_P2 * p3_h;
    proj_pts1 = [proj_pts1(1)/proj_pts1(3), proj_pts1(2)/proj_pts1(3)];
    proj_pts2 = [proj_pts2(1)/proj_pts2(3), proj_pts2(2)/proj_pts2(3)];
    distance_1 = proj_pts1 - pts1(i,:);
    distance_2 = proj_pts2 - pts2(i,:);

    error_1(i) = sqrt(sum(distance_1.^2));
    error_2(i) = sqrt(sum(distance_2.^2));
    
end
plot(error_1);
title("error for P1");
xlabel("pointlabel");
ylabel("error");

plot(error_2);
title("error for P2");
xlabel("pointlabel");
ylabel("error");
