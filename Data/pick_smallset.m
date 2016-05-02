%%EC503 Team Project: Qiuxuan, Aleena and Ganyu
% This file picks out 40 stocks randomly and evenly, 5 each, from the 8 remaining category

close all; clear; clc;

load('stockindustries.mat')

industry = unique(labels);

industry_count = zeros(10,1);
for i = 1:length(labels);
    
    idx = find(strcmp(labels(i),industry));
   
    industry_count(idx) = industry_count(idx)+1;
    
    clear idx
end

labels = labels.';

% we decided to remove category 8 and 9(Mtl and Tele)

tmp1 = find(strcmp(industry(8),labels));

tmp2 = find(strcmp(industry(9),labels));

idx_remove = sort(cat(1,tmp1,tmp2));

clear tmp1 tmp2

% pick randomly from the remaining 8 category, 5 stocks each



for i = 1:10;
    idx = find(strcmp(industry(i),labels));
    n = length(idx);
    tmp = randperm(n);
    tmp = tmp(1:5);
    switch i
            case 1
                index.cat1 = idx;
                tmp1 = idx(tmp);
            case 2
                index.cat2 = idx;
                tmp2 = idx(tmp);
            case 3
                index.cat3 = idx;
                tmp3 = idx(tmp);
            case 4
                index.cat4 = idx;
                tmp4 = idx(tmp);
            case 5
                index.cat5 = idx;
                tmp5 = idx(tmp);
            case 6
                index.cat6 = idx;
                tmp6 = idx(tmp);
            case 7 
                index.cat7 = idx;
                tmp7 = idx(tmp);
            case 10
                index.cat10 = idx;
                tmp10 = idx(tmp);
    end
        clear idx;
        clear tmp;
end

idx_pick = cat(1,tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,tmp7,tmp10);

load('logreturn.mat')
logreturn = logreturn.';

small_set_logreturn = logreturn(idx_pick,:);