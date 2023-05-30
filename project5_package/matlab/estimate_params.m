function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
[U,S,V] = svd(P);
c = V(:,end);
c = [c(1)/c(4),c(2)/c(4),c(3)/c(4)]';
new_P = P(1:3,1:3);
[K,R] = qr(new_P);
if det(R) < 0
   R = -R; 
end
t = -R*c;