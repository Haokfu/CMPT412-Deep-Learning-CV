function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = [mean(x1(:,1)), mean(x1(:,2))];
centroid2 = [mean(x2(:,1)), mean(x2(:,2))];

x1_homo = [x1';ones(1,size(x1,1))];
x2_homo = [x2';ones(1,size(x2,1))];

%% Shift the origin of the points to the centroid
Trans1 = [1,0,-centroid1(1);0,1,-centroid1(2);0,0,1];
Trans2 = [1,0,-centroid2(1);0,1,-centroid2(2);0,0,1];
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
S1 = [sqrt(2)/centroid1(1),0,0;0,sqrt(2)/centroid1(2),0;0,0,1];
S2 = [sqrt(2)/centroid2(1),0,0;0,sqrt(2)/centroid2(2),0;0,0,1];
%% similarity transform 1
T1 = S1 * Trans1;

%% similarity transform 2
T2 = S2 * Trans2;


%% Compute Homography
new_x1 = T1 * x1_homo;
new_x2 = T2 * x2_homo;
new_x1(1,:) = new_x1(1,:)./new_x1(3,:);
new_x1(2,:) = new_x1(2,:)./new_x1(3,:);

new_x2(1,:) = new_x2(1,:)./new_x2(3,:);
new_x2(2,:) = new_x2(2,:)./new_x2(3,:);

input_x1 = [new_x1(1,:)', new_x1(2,:)'];
input_x2 = [new_x2(1,:)', new_x2(2,:)'];

H = computeH(input_x1,input_x2);
%% Denormalization
H2to1 = T1 \ H * T2 ;
