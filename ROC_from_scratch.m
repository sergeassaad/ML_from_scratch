function [X, Y, AUC]  = ROC_from_scratch(labels,predictions)

N_points = length(predictions)*100;
threshold_vec = linspace(min(predictions),max(predictions),N_points);
X = [];
Y = [];
for threshold = threshold_vec
    
    predictions_b = logical(predictions>=threshold);
    TPR = sum(predictions_b == 1 & labels == 1)./sum(labels);
    FPR = sum(predictions_b == 1 & labels == 0)./sum(~labels);
    
    Y = [Y TPR];
    X = [X FPR];
end
AUC = sum(Y)./N_points;
end