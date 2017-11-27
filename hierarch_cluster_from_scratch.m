function [cluster_labels,sorted_coords, sorted_distances] = hierarch_cluster_from_scratch(data,K)
% Author: Serge Assaad
% Date: Nov. 27, 2017
%
% Description:
%     Single-linkage hierarchical clustering algorithm using Euclidean
%     distance (metric can be changed by editing the calc_distance_matrix
%     subroutine)
%
% Args:
%     data: data to be clustered
%     K: Desired number of clusters
%
% Returns:
%     cluster_labels: cluster numbers for each point in data
%     sorted_coords: sequence of ordered pairwise merges, stored as a 2-column
%     matrix
%     sorted_distances: sorted pairwise distances

%% Initialization
N = size(data,1);
cluster_labels = 1:N;
distances_squared = calc_distance_matrix(data);
[sorted_coords, sorted_distances] = sortmat(distances_squared);
num_clusters = N;
ind = 1;
%% Iteration
while(num_clusters>K)
    i = sorted_coords(ind,1);
    j = sorted_coords(ind,2);
    if(cluster_labels(i)<cluster_labels(j))
        cluster_labels(cluster_labels == cluster_labels(j)) = cluster_labels(i);
        num_clusters = num_clusters-1;
    end
    if(cluster_labels(j)<cluster_labels(i))
        cluster_labels(cluster_labels == cluster_labels(i)) = cluster_labels(j);
        num_clusters = num_clusters-1;
    end
    ind = ind+1;
end
end


function distances_squared = calc_distance_matrix(data)
% Calculates NxN distance matrix using Euclidean distance
N = size(data,1);
dot_prods = data*data';
data_norm = diag(dot_prods);
term1 = data_norm*ones(1,N);
term2 = term1';
term3 = -2*(dot_prods);
distances_squared = term1+term2+term3;
end

function [sorted_coords,sorted_distances] = sortmat(distances)
% Sorts distances and outputs the coordinates of each distance within the
% distance matrix (the pair of points corresponding to that distance)
N = size(distances,1);
[sorted_distances,inds] = sort(distances(:)); %vectorize the matrix and sort it
rownums = mod(inds-1,N)+1; %calculate row number in matrix from location in vector
colnums = ceil(inds/N); %calculate column number in matrix from location in vector
rownums = rownums(N+1:end); %remove diagonal entries (0 distance)
colnums = colnums(N+1:end);
rownums = rownums(1:2:end); %remove duplicate entries (distance matrix is symmetric)
colnums = colnums(1:2:end);
sorted_coords = [rownums,colnums];
end