function [ bestH2to1, inliers,best_pairs] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
% get size of locs1 and locs2
size_locs = size(locs1,1);
num_of_sample = 4;
inliers = [];
% threshold = 10;
max_inlier_count = 0;
best_inliers = [];
best_H = [];
if num_of_sample > size_locs
    num_of_sample = size_locs;
end
best_point_pairs = [];
max_iter = 10000;
for i = 1:max_iter
    pred_x1 = zeros(num_of_sample,2);
    pred_x2 = zeros(num_of_sample,2);
    pred_ind_x2 = randperm(size_locs,num_of_sample); %randomly pick 4 points
    for j = 1:num_of_sample
        pred_x1(j,:) = locs1(pred_ind_x2(j),:);
        pred_x2(j,:) = locs2(pred_ind_x2(j),:);
    end
    H = computeH_norm(pred_x1,pred_x2);
    x_homo = [locs2,ones(size_locs,1)];
    x_homo = x_homo';
    pred_x_output = H * x_homo;
    pred_x_output = pred_x_output ./ pred_x_output(3,:);
    
    pred_locs1 = [pred_x_output(1,:);pred_x_output(2,:)]';
    %pred_locs1 is the result computed by H, 
    % locs1 is the real matched points
    
    inlier_in_loop = [];
    inlier_count = 0;
    k = 1;
    for j = 1:size_locs
        p1 = pred_locs1(j,:);
%         p1
        p2 = locs1(j,:);
%         p2
        %get points1 and points2
        d = sqrt((p1(1) - p2(1)).^2 + (p1(2) - p2(2)).^2);
%         d
        
        if d <= 0.5
            %this means this points is inlier
            inlier_in_loop(k) = j;
            inlier_count = inlier_count + 1;
            k = k+1;
        end
    end
    %after this loop, we get inlier arrays and inlier count. 
    % compare it with max_count and best_inliers
    if inlier_count > max_inlier_count
        best_inliers = inlier_in_loop;
        max_inlier_count = inlier_count;
        best_H = H;
        best_point_pairs = pred_ind_x2;
    end
end
%now I have my best_H and best_inliers
bestH2to1 = best_H;
inliers = best_inliers;
best_pairs = best_point_pairs;
%Q2.2.3
end

