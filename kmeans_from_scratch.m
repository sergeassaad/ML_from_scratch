function data_labels = kmeans_from_scratch(data,K,convergence_criterion)
% Author: Serge Assaad
% Date: Nov. 5, 2017
%
% Description:
%     K-means algorithm, uses (cost)/(initial cost) as convergence
%     criterion
%
% Args:
%     data: data to be clustered
%     K: Desired number of clusters
%     convergence_criterion: Specifies threshold below which convergence
%     holds (i.e. condition for convergence is:
%             (cost)/(initial cost) < convergence_criterion  )
%
% Returns:
%     data_labels: cluster numbers for each point in data

%% Initialization
random_index = randperm(size(data,1));
centers = data(random_index(1:K),:); %initialize centers as random points in the set

[init_cost, data_labels] = kmeans_cost(data,centers,K);
cost = init_cost;

%% Iteration
while(cost/init_cost>convergence_criterion)
    for cluster_number = 1:K
        centers(cluster_number,:) = mean(data(data_labels==cluster_number,:));
    end
    [cost, data_labels] = kmeans_cost(data,centers,K);
end
end

%% Cost function definition
function [cost, data_labels] = kmeans_cost(data,centers,K)
center_labels = 1:K;
[data_labels, ~,~] = knn_from_scratch(centers,data,center_labels,1);
cost = 0;
for cluster_num = 1:K
    curr_cluster = data(cluster_num == data_labels);
    cost = cost + sum((curr_cluster - centers(cluster_num)).^2);
end
end