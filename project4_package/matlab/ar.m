% Q3.3.1
clear;
vid_panda = loadVid('../data/ar_source.mov');
% for i = 1:511
%     imshow(vid(i).cdata)
% end

vid_book = loadVid('../data/book.mov');
cv_img = imread('../data/cv_cover.jpg');

video = VideoWriter('../results/ar.avi');
open(video);

number_of_frames = size(vid_panda,2);
for i = 1:number_of_frames

    i
    frame_img = vid_book(i).cdata;
    
    % Extract features and match
    [locs1, locs2] = matchPics(cv_img, frame_img);
    
    % Compute homography using RANSAC
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    

    panda_img = vid_panda(i).cdata;
    height = size(panda_img,1);
    width = size(panda_img,2);
    % Scale harry potter image to template size
    %crop forst
    panda_img = panda_img(:,ceil(width/3):ceil(width*2/3),:);
    scaled_panda_img = imresize(panda_img, [size(cv_img,1) size(cv_img,2)]);
    
    % Display warped image.
%     imshow(warpH(scaled_panda_img, inv(bestH2to1), size(frame_img)));
%     
%     % Display composite image
%     imshow(compositeH(inv(bestH2to1), scaled_panda_img, frame_img));
    current_frame = compositeH(inv(bestH2to1), scaled_panda_img, frame_img);
    writeVideo(video, current_frame);
end
close(video);

