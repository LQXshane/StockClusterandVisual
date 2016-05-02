clear all
close all
clc

%Load raw data and labels
load logreturn.mat
load stockindustries.mat
poss_labels = unique(labels);
num = 1:length(poss_labels);
for m = 1:length(labels)
    ydata(:,m) = num(ismember(poss_labels,labels{m}));
end
n = size(logreturn,2);

% Compute distances for k-NN
for i = 1:n
    for j = 1:n
        distances(i,j) = sqrt(sum((logreturn(:,i)-logreturn(:,j)).^2));
    end
end

% Determine k-NN
[dist_sort ind] = sort(distances,2);
%%%%this section comes from http://stackoverflow.com/questions/5643614/matlab-sort-2d-and-3d-matrix-and-access-through-index
% Compute indices for labels matrix
[rows cols] = size(distances);
tmp = repmat((1:rows)',[1 cols]);
nInd = tmp+(ind-1)*rows;
%%%%
kNN = distances;
kNN(nInd(:,[1 435:end])) = Inf;

% Compute ISOMAP D, delta, H, and K
D = dijkstra(kNN,[]); % dijkstra and dijk functions come from class hmwk - Matlab Exercise 5
delta = D.^2;

H = eye(n)-((ones(n,1)*ones(1,n))./n);

Kiso = (-1/2)*H*delta*H;

% Find eigen values of K, compute lambda
rng('default')
[Viso,tmp] = eigs(Kiso,2);
lambda_iso = sqrt(tmp);

% Embed data in 2D
yiso = (lambda_iso*Viso')';

% Plot colored by truth labels or clusters
figure(1)
gscatter(yiso(:,1),yiso(:,2),labels',[],[],10) % Change 'labels' to vector of cluster labels to plot colored by cluster labels
title('2D ISOMAP Representation of Data Clustered Using Kmeans') % Change title accordingly