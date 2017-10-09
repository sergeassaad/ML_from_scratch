%% Make Data Set and labels
rng(1);
A = 2*rand([10,2]);
B = 1*rand(10,2)+3;
data_train = [A;B];
labels_train = [zeros(10,1);ones(10,1)];

data_test = 1*rand(10,2)+1.7;
%% Plot training data (colored) and test data (black)

figure(1);clf
plot(A(:,1),A(:,2),'bx');
hold on;
plot(B(:,1),B(:,2),'rs');
plot(data_test(:,1),data_test(:,2),'ko');

%% Run KNN and plot colored test data
K = 3;

labels_test = knn_from_scratch(data_train,data_test,labels_train,K);

figure(2); clf
plot(A(:,1),A(:,2),'bx');
hold on;
plot(B(:,1),B(:,2),'rs');

plot(data_test(labels_test==0,1),data_test(labels_test==0,2),'bo');
plot(data_test(labels_test==1,1),data_test(labels_test==1,2),'ro');


