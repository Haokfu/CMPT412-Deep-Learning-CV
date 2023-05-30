function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!


%% Convert images to grayscale, if necessary
if size(I1,3) ~= 1
    I1 = rgb2gray(I1);
end
if size(I2,3) ~= 1
    I2 = rgb2gray(I2);
end

%% Detect features in both images
coners1 = detectFASTFeatures(I1);
coners2 = detectFASTFeatures(I2);

% coners1 = detectSURFFeatures(I1);
% coners2 = detectSURFFeatures(I2);

%% Obtain descriptors for the computed feature locations
[desc1,f1] = computeBrief(I1,coners1.Location);
[desc2,f2] = computeBrief(I2,coners2.Location);

% [desc1,f1] = extractFeatures(I1,coners1,"Method","SURF");
% [desc2,f2] = extractFeatures(I2,coners2,"Method","SURF");

%% Match features using the descriptors
ind = matchFeatures(desc1,desc2,"MatchThreshold",10.0,"MaxRatio",0.7);
matchedPoints1 = f1(ind(:,1),:);
matchedPoints2 = f2(ind(:,2),:);

% ind = matchFeatures(desc1,desc2);
% matchedPoints1 = f1(ind(:,1));
% matchedPoints2 = f2(ind(:,2));

% figure; 
%showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
% title("Putative point matches");
% legend("Matched points 1","Matched points 2");

locs1 = matchedPoints1;
locs2 = matchedPoints2;
end

