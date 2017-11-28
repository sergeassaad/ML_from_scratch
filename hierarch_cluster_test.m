%% Make Data Set
rng(1);
A = 2*rand(10,2);
B = 1*rand(10,2)+3;
C = 1.5*rand(10,2)+1.5;
data = [A;B;C];

%% Plot before clustering

figure(1); clf
plot(data(:,1),data(:,2),'ko');
title('unlabeled data');

%% Hierarchical clustering
K = 3;
data_labels = hierarch_cluster_from_scratch(data,K);
cluster_nums = unique(data_labels);

%% Plot after clustering

figure(2); clf
for cluster_index = 1:K
curr_cluster = data(data_labels == cluster_nums(cluster_index),:);
plot(curr_cluster(:,1),curr_cluster(:,2),'o');
hold on;
end
title('Clustered!');
