function pts3d = mytriangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
nop = size(pts1,1);
pts3d = zeros(nop,3);
for i = 1:nop
    p1 = pts1(i,:);
    x1 = [p1,1]';
    p2 = pts2(i,:);
    x2 = [p2,1]';
    A = [x1(1) * P1(3,:) - P1(1,:);
        x1(2) * P1(3,:) - P1(2,:);
        x2(1) * P2(3,:) - P2(1,:);
        x2(2) * P2(3,:) - P2(2,:)];
    [U,S,V] = svd(A);
    p3 = V(:,end);
    p3 = [p3(1)/p3(4), p3(2)/p3(4), p3(3)/p3(4)];
    pts3d(i,:) = p3;
end