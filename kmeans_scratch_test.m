%% Make Data Set
rng(1);
A = 2*rand(10,2);
B = 1*rand(10,2)+3;
C = 1.5*rand(10,2)+1.5;
data = [A;B;C];

%% Plot before kmeans

figure(1); clf
plot(data(:,1),data(:,2),'ko');
title('unlabeled data');
%% Kmeans
K = 3;
convergence_criterion = 0.8;
data_labels = kmeans_from_scratch(data,K,convergence_criterion);
cluster_1 = data(data_labels ==1,:);
cluster_2 = data(data_labels ==2,:);
cluster_3 = data(data_labels ==3, :);
%% Plot after Kmeans

figure(2); clf
for cluster_num = 1:K
curr_cluster = data(data_labels == cluster_num,:);
plot(curr_cluster(:,1),curr_cluster(:,2),'o');
hold on;
end
title('Clustered!');
