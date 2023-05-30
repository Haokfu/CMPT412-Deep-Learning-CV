function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
kernel = ones(windowSize, windowSize);
height = size(im1,1);
width = size(im1,2);
template_im = zeros(height, width);


all_disps = zeros(height,width,maxDisp+1); %potential problem here: wrong dimensions


dispM = zeros(height,width);

for d = 0:maxDisp
    % get last (width-d) columns of im1 and first (width-d) columns of im2
    im1_sample = im1(:,d+1:width);
    im2_sample = im2(:,1:width-d);

    template_im(:,d+1:width) = (im1_sample-im2_sample).^2;
    all_disps(:,:,d+1) = conv2(template_im, kernel,'same');
end
% all_dips is maxDisp+1 depth, first convolution then find min



[~,index] = min(all_disps,[],3);
size(index);
dispM = index-1;