function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
% x1
% x2

n = size(x1,1);
x1Col = x1(:,1);
x2Col = x2(:,1);
y1Col = x1(:,2);
y2Col = x2(:,2);

xDot = [x1Col.*x2Col, x1Col.*y2Col, x1Col];
yDot = [y1Col.*x2Col, y1Col.*y2Col, y1Col];

%put x in a n*1 matrix
XYCol = [x2Col,y2Col,ones(n,1)];
xMatrix = [XYCol, zeros(n,3), -xDot];
yMareix = [zeros(n,3), XYCol, -yDot];
A = zeros(2*n,9);
j = 1;
for i = 1:2:2*n
    A(i,:) = xMatrix(j,:);
    A(i+1,:) = yMareix(j,:);
    j = j+1;
end
[U,S,V] = svd(A);
h = V(:,end);
H2to1 = reshape(h,3,3)';

end
