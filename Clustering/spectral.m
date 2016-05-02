%% Spectral by Qiuxuan 
% spectral clustering on raw data using cross-correlation coeffient matrix as similarity matrix

close all; clc; clear;

%load raw data and labels(same for large and small dataset), set k = number of industrial labels
load('logreturn.mat');

load('stockindustries.mat');

k = 10;


% % This part is for trying out gaussian as S, we didn't go with this
% % data = logreturn;
% % n = length(data.');
% % S = zeros(n,n);
% % for i = 1:n;
% %     for j = 1:n;
% %         l2 = norm(data(i,:)-data(j,:))^2;
% %         S(i,j) = exp(-l2/0.08);
% %     end
% % end
% % 
% % D = diag(sum(S));
% % W = S;

W = corrcoef(logreturn);

n = length(W);

D = diag(sum(W));

% SC-2 performs best**

% sc1.unnormalized
 L = D - W;
% sc2.normalized
d1=diag(sum(W).^-1);
L = d1*L;
% % sc3.normalized 
% % d2 = diag(sum(W).^-1/2);
% % L = d2*L*d2;


[V,value] = eig(L);

vtemp = diag(value);

[b,I] = sort(vtemp,'ascend');

eigenVector = zeros(n,n);

eigenValue = zeros(n,n);

for i = 1:n;
    
   eigenVector(:,i) = V(:,I(i));
   
   eigenValue(i,i) = vtemp(I(i));
   
end

V = eigenVector(:,1:k);

n = 437;

name = unique(labels);

numlabel = zeros(n,1);

for i = 1:n;
    
    for j = 1:k;
        
        if strcmp(labels(i),name{j});
            
          numlabel(i) = j;
          
        end
    end
    
end


rng(2)
[idx,C,sumd,Distance] = kmeans(V,k,'Distance','correlation','Replicates',20);






%% This part uses Ganyu's code for counting stocks in each cluster in comparison to RMT method
P1 = [];

P2 = [];



Dnumber = {};

Dlabel = {};

for i = 1:k;
   for j = 1:n;
       
       if idx(j) == i;
           
           P1 = [P1,j];
           
           P2 = [P2,numlabel(j)];
           
       end  
   end
   
   Dnumber{i} = P1;
   Dlabel{i} = P2;
   P1 = [];
   P2 = [];
end

