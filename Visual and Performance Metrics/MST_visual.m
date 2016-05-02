%% EC 503 Team Project: Qiuxuan
% MST of empirical correlation coeffiecient matrix
% Credit: UndirectedMaximumSpanningTree, Copyright (c) 2009, Li Guangdi.
% Keep .m file in the same folder


% Qiuxuan: To run this code, must change built-in function 'biograph.m',
% the following lines starting from line 184:
%-----------------------------------------------------------%
%     % checking there are not repeated IDs
%     if numel(unique(ids))~=n
%         warning(message('bioinfo:biograph:biograph:notUniqueIDS'))
%        setDefaultIDS = true;
%     end
%-----------------------------------------------------------%


close all; clear; clc;
 
%------load this part for RMT+k means results---------%
load('idx_RMT.mat');

load('labelformax10RMT_regress.mat');

% load this part for specrtal clustering results
%  load('spectral_sc2_10-means_idx.mat');
%  load('spectral_cluster_result.mat');
% FOR K-MEANS
%  load('k_means_100.mat');
%  idx = cluster;

load('stockindustries.mat');

%% This part uses Ganyu's code for comparison
name={};
name=unique(labels);
numlabel=zeros(437,1);
for i=1:437
    for j=1:10
        if strcmp(labels(i),name{j});
          numlabel(i)=j;
        end
    end
    
end
P1 = [];
P2 = [];
Dnumber = {};
Dlabel = {};
k = 10;
for i = 1:k
   for j = 1:437
       if idx(j) == i
           P1 = [P1,j];
           P2 = [P2,numlabel(j)];
       end  
   end
   i
   Dnumber{i}=P1;
   Dlabel{i}=P2;
   P1=[];
   P2=[];
end

 
 
 %----------construct the tree---------------%
load('logreturn.mat');
stock_cov = corrcoef(logreturn);

[ Tree,~ ] =  UndirectedMaximumSpanningTree (stock_cov);

n = length(Tree);
newTree = Tree;
load('stockname.mat');
for i = 1:n;
    
    newTree(i,1:i)=0;
end

%% calculate the dominant labels for each cluster



k = 10;
maxd = zeros(k,1);
for i = 1:k;
    ddd = Dlabel{1,i};
    dd = length(ddd);
    nnn = unique(ddd);
    nn = length(nnn);
    count = zeros(nn,1);
    
        for t = 1:nn;
           for j = 1:dd;
            if ddd(j) == nnn(t)
                 count(t) = count(t)+1;
            end
           end
        end
    [~,index]= max(count);
    maxd(i) = nnn(index);
end

load('stockindustries.mat');
industry = unique(labels);

%cluster = 1:10;

input = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j'};
numericalLabel = {};
for i = 1:437;
      numericalLabel{i} = input{maxd(idx(i))};
%         numericalLabel{i} = input{find(strcmp(labels(i),industry))}; %
%         this line commented here is for constructing the original truth
%         labeled tree
end
 G = biograph(newTree,numericalLabel,'LayoutType','radial');



nodeHandlers = G.Nodes;
color = [3 103 255 47 249 0 37 51 255 0 253 254 255 38 0 203 59 254 202 250 0 255 150 0 255 48 154 3 250 100];
color = color./255;
for i = 1:437;
    
    index = find(strcmp(nodeHandlers(i).ID,input));
   
   
    R = color(3*index-2);
    g = color(3*index-1);
    B = color(3*index);
    set(nodeHandlers(i),'Color',[R g B]);
    
    
end
set(nodeHandlers,'Shape','circle')
G.NodeAutoSize = 'off';

set(nodeHandlers,'Size',[20 20])
G.Scale = 0.5;

view(G);




