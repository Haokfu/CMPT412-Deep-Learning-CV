%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
max_P_all = zeros(size(ytest));
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~,max_P] = max(P,[],1);
    max_P_all(i:i+99) = max_P;
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