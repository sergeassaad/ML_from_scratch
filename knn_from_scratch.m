function [predictions_test, K_nearest_indices,scores] = knn_from_scratch(data_train,data_test,labels_train,K)

% Author: Serge Assaad, Sep 23, 2017
% Assumptions:
% - training and test data stored in matrices with samples as rows
% - labels_test is a column vector
% - L2 norm for distance
if(~iscolumn(labels_train))
    labels_train = labels_train';
end
N = size(data_train,1);
M = size(data_test,1);

data_train_norm = diag(data_train*data_train');
data_test_norm = diag(data_test*data_test');

term1 = data_train_norm*ones(1,M);
term2 = data_test_norm*ones(1,N);
term3 = -2*data_train*data_test';

distances_squared = term1+term2'+term3;

[~, sort_indices] = sort(distances_squared);
labels_train_matrix = labels_train*ones(1,M);
labels_train_sorted = labels_train_matrix(sort_indices);
K_nearest_indices = sort_indices(1:K,:);
K_nearest_labels = labels_train_sorted(1:K,:);
predictions_test = mode(K_nearest_labels,1)';
scores = sum(K_nearest_labels)./K;
end