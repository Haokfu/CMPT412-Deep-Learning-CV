function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
c1 = -inv(K1*R1) * (K1 * t1);
c2 = -inv(K2*R2) * (K2 * t2);

b = sqrt(sum((c1-c2).^2));

f = K1(1,1);
height = size(dispM, 1);
width = size(dispM, 2);

depthM = zeros(height,width);

for i = 1:size(dispM,1)
    for j = 1:size(dispM,2)
        i;
        if dispM(i,j) > 0
            dispM(i,j);
            depthM(i,j) = b*f / dispM(i,j);
        end
    end
end
end