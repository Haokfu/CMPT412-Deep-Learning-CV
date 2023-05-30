function [input_od] = relu_backward(output, input, layer)

    % Replace the following line with your implementation.
    input_od = zeros(size(input.data));
    
    der = input.data > 0;
    input_od = (output.diff) .* der;
    
end
