function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
nop = size(pts1,1);
height = size(im2,1);
width = size(im2,2);
window_size = 20;
pts2 = zeros(nop,2);
for i = 1:nop
    x1 = pts1(i,:);
    %find l'
    x1_h = [x1,1]';
    epipolar_line = F * x1_h;
    epipolar_line = epipolar_line/-(epipolar_line(2));
    window1 = double(im1(x1(2)-window_size:x1(2)+window_size, x1(1)-window_size:x1(1)+window_size, :));
    x2_min = 0;
    y2_min = 0;
    least_dist = 10000;
    for j = x1(:,1)-30:x1(:,1)+30
        x2 = j;
        y2 = round(epipolar_line(1) * x2 + epipolar_line(3));
        if y2-window_size > 0 && y2+window_size < height
            window2 = double(im2(y2-window_size:y2+window_size, x2-window_size:x2+window_size, :));
            window_dist = window1 - window2;
            distance = sqrt(sum(sum(window_dist.^2)));
            if distance < least_dist
                least_dist = distance;
            
                x2_min = x2;
                y2_min = y2;
               
            end
        end
    end
    pts2(i,1) = x2_min;
    pts2(i,2) = y2_min;

     
end