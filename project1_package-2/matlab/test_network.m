%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
 
end
% pints_sum = zeros(4,size(P,1));
% for j = 1:size(P,1)
%     tempdata = P(j,:);
%     logic_array = (tempdata < 0.975) && (tempdata > 0.025);
%     sum = 0;
%     for index = 1:size(P,2)
%         if logic_array == 1
%             sum = sum + 1;
%         end
%     end
%     points_sum(:,j) = sum;
% end
% top1index = find(max(points_sum) == points_sum);
% points_sum(top1index) = 0;
% top2index = find(max(points_sum) == points_sum);
max_P_all = zeros(size(ytest));
layers{1}.batch_size = 50;
for i=1:50:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+49));
    max_P_all(:,i:i+49) = max(P,[],1);
end

ytest_ = {};
max_P_all_ = {};
for i = 1:length(ytest)
    ytest_{i} = num2str(ytest(i));
    max_P_all_{i} = num2str(max_P_all(i));
end
ytest_= categorical(ytest_);
max_P_all_ = categorical(max_P_all_);

figure;
plotconfusion(ytest_,max_P_all_);




