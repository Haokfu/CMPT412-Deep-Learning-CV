img1 = imread("../data/cv_cover.jpg");
img2 = imread("../data/cv_desk.png");

[locs1,locs2] = matchPics(img1,img2);

H = computeH(locs1,locs2);

pred_locs1 = [locs1';ones(1,size(locs1,1))];
pred_locs2 = inv(H) * pred_locs1;
pred_locs2 = pred_locs2 ./ pred_locs2(3,:);

pred_locs2 = [pred_locs2(1,:);pred_locs2(2,:)]';

rand_int = randperm(size(locs1,1),10);

input_locs1 = zeros(10,2);
input_locs2 = zeros(10,2);
for i = 1:10
    input_locs1(i,:) = locs1(rand_int(i),:);
    input_locs2(i,:) = pred_locs2(rand_int(i),:);
end

showMatchedFeatures(img1,img2,input_locs1,input_locs2,"montage");