clear all
close all
clc

% Load raw data
load stockprice.mat
load stockname.mat
load stockindustries.mat
xdata = data';
poss_labels = unique(labels);
num = 1:length(poss_labels);
for m = 1:length(labels)
    ydata(:,m) = num(ismember(poss_labels,labels{m}));
end

% Apply k-means
rng(2);
[cluster,centroid,sumd] = kmeans(xdata,10,'Distance','sqeuclidean','Replicates',20);

% Following for reference only
ypredict = zeros(length(ydata),1);
for k = 1:10
    ytemp = ydata(cluster==k);
    [clust_label,num_in_clust] = mode(ytemp);
    ypredict(cluster==k) = clust_label;
    clear ytemp
    clear clust_label
end

con_mat = confusionmat(ydata',ypredict);
CCR = (sum(diag(con_mat)))/length(ydata);