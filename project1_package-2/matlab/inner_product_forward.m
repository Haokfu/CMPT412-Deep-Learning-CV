%  input.data = zeros(25,2);
%     input.data(6:3:end) = 1.0;
%     input.data(7:3:end) = 0.5;
%     input.height = 25;
%     input.width = 1;
%     input.channel = 1;
%     input.batch_size = 2;
%     
%     layer.type = 'IP';
%     layer.num = 25;
%     
%     params.w = eye(25);
%     params.w(1:25*10) = 0;
%     params.w(2, 5) = 0.5;
%     params.w(3, 4) = 0.5;
%     params.b = zeros(1,25);
%     params.b(1,2) = 0.5;
%     params.b(1,4) = 0.5;
%     
%     output = inner_product_forwar(input, layer, params);


function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
output.data = zeros([n, k]);
output.height = n;
output.width = 1;
output.channel = 1;
output.batch_size = input.batch_size;


for i = 1:k
    for j = 1:n
        dt = input.data(:,i);
        output.data(:,i) = dt' * param.w + param.b;
    end
end


end
