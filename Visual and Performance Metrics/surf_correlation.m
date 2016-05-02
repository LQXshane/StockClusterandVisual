%%Use surf function to visualize the correlation matrix

close all; clear; clc;

load logreturn.mat

load stockindustries.mat

logreturn = logreturn.';
labels = labels.';

industry = unique(labels);
n = length(industry);
x = zeros(437,1568);
sort_idx = [];
for i = 1:10;
    idx = find(strcmp(industry(i),labels));
    sort_idx = cat(1,sort_idx,idx);
    clear idx
end

x = logreturn(sort_idx,:);

W = corrcoef(x.');



n = length(W);
D = diag(sum(W));
L = D - W;
d=diag(sum(W).^-1);
L = d*L;


surf(L,'EdgeColor','None');
view(2);
