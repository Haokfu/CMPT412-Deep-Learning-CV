% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1 = im2double(imread('..\data\cv_cover.jpg'));
if size(I1,3) ~= 1
    I1 = rgb2gray(I1);
end

%% Compute the features and descriptors
features = detectFASTFeatures(I1);
descs = computeBrief(I1,features.Location);
hist = zeros(37,1);
angle = 10;
for i = 0:36
    %% Rotate image
    I2 = imrotate(I1,i*angle);
    %% Compute features and descriptors
    features2 = detectFASTFeatures(I2);
    descs2 = computeBrief(I2,features2.Location);
    %% Match features
    [locs1,locs2] = matchPics(I1,I2);
    %% Update histogram
    hist(i+1,1) = size(locs1,1);
%     size(locs1,1)
    angle = angle + 10;
end

%% Display histogram
bar(0:10:360,hist);
title("count of matched features");
xlabel("rotation angular");
ylabel("number of matched features");