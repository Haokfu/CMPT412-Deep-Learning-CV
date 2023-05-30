% input.data = zeros(25, 2);
%     input.data(13, 1) = 1;
%     input.data(14, 2) = 1;
%     input.width = 5;
%     input.height = 5;
%     input.channel = 1;
%     input.batch_size = 2;
% 
%     conv_layer.type = 'CONV';
%     conv_layer.num = 3;
%     conv_layer.k = 5;
%     conv_layer.stride = 1;
%     conv_layer.pad = 2;
%     
%     params.w = zeros(25,3);
%     params.w(14, 1) = 0.5; % move image down by one pixel on red channel
%     params.w(12+5, 3) = 0.5; % move image opposite dir blue channel
%     params.b = [0.25, 0.0, 0.25];
% 
%     output = conv_layer_forwar(input, conv_layer, params);
% 


function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;
% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;
weight_size = size(param.w,1);

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
% input_n.height = h_in;
% input_n.width = w_in;
% input_n.channel = c;

%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 
col = im2col_conv_batch(input,layer,h_out,w_out);
output.height = h_out;
output.width = w_out;
output.batch_size = batch_size;
output.channel = num;
output.data = zeros(h_out * w_out * num, batch_size);


for i = 1 : input.batch_size
    otdata = zeros(h_out*w_out,num);
    for j = 1 : num
        otdata(:,j) = ((param.w(:,j))' * col(:,:,i) + param.b(:,j))';
    end
    output.data(:,i) = reshape(otdata, h_out * w_out * num, 1);
end


end

