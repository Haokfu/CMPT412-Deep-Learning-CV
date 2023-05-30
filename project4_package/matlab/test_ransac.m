img1 = imread("../data/cv_cover.jpg");
img2 = imread("../data/cv_desk.png");

[locs1,locs2] = matchPics(img1,img2);

[H,inliers,best_pairs] = computeH_ransac(locs1,locs2);
% visualise best four_points

new_locs1 = zeros(4,2);
new_locs2 = zeros(4,2);
for i = 1:4
    new_locs1(i,:) = locs1(best_pairs(i),:);
    new_locs2(i,:) = locs2(best_pairs(i),:);
end
% figure();
showMatchedFeatures(img1,img2,new_locs1,new_locs2,"montage");
p_size = size(inliers,2);

input_locs1 = zeros(p_size,2);
input_locs2 = zeros(p_size,2);

for i = 1:size(inliers,2)
    input_locs1(i,:) = locs1(inliers(i));
    input_locs2(i,:) = locs2(inliers(i));
end
hold on;
showMatchedFeatures(img1,img2,input_locs1,input_locs2,"montage");



