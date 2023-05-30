function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%% Normalize: 
% divide by M
p1 = pts1 ./ M;
p2 = pts2 ./ M;


% % subtracting by mean
% x1_mean = [mean(x1(:,1)), mean(x1(:,2))];
% x2_mean = [mean(x2(:,1)), mean(x2(:,2))];
% x1 = x1 - x1_mean;
% x2 = x2 - x2_mean;
% % distance to sqrt(2)


%% find A
nop = size(pts1,1);
one_vec = ones(nop,1);
x1 = p1(:,1);
x2 = p2(:,1);
y1 = p1(:,2);
y2 = p2(:,2);
A = [x2.*x1, x2.*y1, x2, y2.*x1, y2.*y1, y2, x1, y1, one_vec];
A;
%% use SVD to get f
[U,S,V] = svd(A);
f = V(:,end);
F = reshape(f,3,3)'; %potential problem here
%% enforce 2 rank to F

[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

%% Unscale F
F = refineF(F, p1, p2);

Trans = [1/M,0,0; 0,1/M,0; 0,0,1];
F_unscale = Trans' * F * Trans;

F = F_unscale;
end
% normalized1 = pts1./M;
% normalized2 = pts2./M;
% num_points = size(pts1,1);
% 
% A = ones(num_points,9);
% 
% for i= 1:num_points
%     x1 = normalized1(i,1);
%     y1 = normalized1(i,2);
%     x2 = normalized2(i,1);
%     y2 = normalized2(i,2);
%     
%     A(i,:) = [x2*x1,x2*y1, x2, y2*x1, y2*y1, y2, x1, y1, 1];
% end
% 
% [U,S,V] = svd(A);
% F = reshape(V(:,end),3,3);
% 
% [U,S,V] = svd(F);
% S(3,3) = 0;
% F_dash = U*S*V';
% 
% F_refine = refineF(F_dash, normalized1,normalized2);
% scaled = [1/M,0,0;0,1/M,0;0,0,1;];
% 
% F = scaled' * F_refine* scaled;
% end