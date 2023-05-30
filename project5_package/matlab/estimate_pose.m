function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
nop = size(x,2);
A = zeros(2*nop,12);
for i = 1:nop
    x_pt = x(1,i);
    y_pt = x(2,i);
    X_pt = X(1,i);
    Y_pt = X(2,i);
    Z_pt = X(3,i);
    temp_mat = [X_pt,Y_pt,Z_pt,1,0,0,0,0,-x_pt*X_pt,-x_pt*Y_pt,-x_pt*Z_pt,-x_pt;
        0,0,0,0,X_pt,Y_pt,Z_pt,1,-y_pt*X_pt,-y_pt*Y_pt,-y_pt*Z_pt,-y_pt];
    A(2*i-1,:) = temp_mat(1,:);
    A(2*i,:) = temp_mat(2,:);
end
[U,S,V] = svd(A);
p = V(:,end);
P = reshape(p,4,3)';
