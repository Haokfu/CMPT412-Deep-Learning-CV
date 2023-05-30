% input.data = zeros(36*3,2);
%     input.data(13, 1) = 0.5;
%     input.data(14, 1) = 0.25;
%     input.data(15, 1) = 0.5;
%     input.data(20 + 50, 1) = 0.75;
%     % image 2
%     input.data(15, 2) = 0.25;
%     input.data(16, 2) = 0.75;
%     input.data(6 + 36, 2) = 0.75;
%     input.data(12 + 72, 2) = 0.75;
%     input.width = 6;
%     input.height = 6;
%     input.channel = 3;
%     input.batch_size = 2;
%     
%     layer.type = 'POOLING';
%     layer.k = 2;
%     layer.stride = 2;
%     layer.pad = 0;
%     
%     output = pooling_layer_forwar(input, layer);
%     %display_results(input, output, 'Pooling Test');

function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;
    kernal_size = k*k;
    % Replace the following line with your implementation.
    output.data = zeros([h_out*w_out*c, batch_size]);
    for i = 1:input.batch_size
        new_data = reshape(input.data(:,i),input.height,input.width,input.channel);
        index = 1;
        for j = 1:c
            channel_data = new_data(:,:,j);
            %op_c = 1;
            for col = 1:stride:(w_in-stride+1)
                %op_r = 1;
                for r = 1:stride:(h_in-stride+1)
                    data_prep = reshape(channel_data(r:(r+k-1),col:(col+k-1)),[],kernal_size);
                    output.data(index,i) = max(data_prep);
                    index = index+1;
                end
                %op_c = op_c + 1;
            end
        end
    end

end

