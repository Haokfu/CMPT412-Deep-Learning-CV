layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
% fullset = false;
% [xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
% xtrain = [xtrain, xvalidate];
% ytrain = [ytrain, yvalidate];
% m_train = size(xtrain, 2);
% batch_size = 64;
real_world_data = zeros(784,5);
real_world_data(:,1) = load_number('digit_image1.jpg');
real_world_data(:,2) = load_number('digit_image2.jpg');
real_world_data(:,3) = load_number('digit_image3.jpg');
real_world_data(:,4) = load_number('digit_image4.jpg');
real_world_data(:,5) = load_number('digit_image5.jpg');
 
layers{1}.batch_size = 1;
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
result_matrix = zeros(500,5);

for i = 1:5
    output = convnet_forward(params, layers, real_world_data(:,i));
    result_matrix(:,i) = output{9}.data;
end

filename = 'real_world_output.mat';
save(filename, 'result_matrix');
% output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.

% figure;
% output_2 = reshape(output{2}.data, output{2}.height, output{2}.width,output{2}.channel,output{2}.batch_size);
% for i = 1:20
%     subplot(4,5,i);
%     tmp = output_2(:,:,i,1);
%     imshow(tmp',[]);
% end
% 
% figure;
% output_3 = reshape(output{3}.data, output{3}.height, output{3}.width,output{3}.channel,output{3}.batch_size);
% for i = 1:20
%     subplot(4,5,i);
%     tmp = output_3(:,:,i,1);
%     imshow(tmp',[]);
% end