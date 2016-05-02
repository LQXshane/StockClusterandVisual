clear all

close all

clc


% Load raw data
load logreturn.mat

load stockname.mat

load stockindustries.mat

poss_labels = unique(labels);

num = 1:length(poss_labels);

for m = 1:length(labels)

    ydata(:,m) = num(ismember(poss_labels,labels{m}));

end

% Load vector of cluster assignments
load('final_RMT+spectral_gaussian.mat'); % Change file to load accordingly
cluster = idx;


% Set N, allocate ypredict
N = length(ydata);

ypredict = zeros(N,1);

% Compute interim steps for metrics
for k = 1:10

    for kk = 1:length(poss_labels);

        if k==1

            num_label(kk) = sum(ydata==kk);

        end

        num_in_clust(k,kk) = sum(ydata(cluster==k)==kk);
        
    end
    
    for kk = 1:length(poss_labels);
        
        if k==10
            
        tmp2 = (num_in_clust(:,kk)./N).*log((num_in_clust(:,kk))./(num_label(kk)));
        
        cond_entropy_data_tmp(kk) = sum(tmp2(~isnan(tmp2)));
        
        end
        
    end

    total_clust(k) = sum(cluster==k);

    tmp1 = (num_in_clust(k,:)./N).*log((N.*num_in_clust(k,:))./(total_clust(k).*num_label));

    mutual_info(k) = sum(tmp1(~isnan(tmp1)));
    
    

    tmp3 = (num_in_clust(k,:)./N).*log((num_in_clust(k,:))./(total_clust(k)));

    cond_entropy_clust_tmp(k) = sum(tmp3(~isnan(tmp3)));

    ytemp = ydata(cluster==k);

    [clust_label,max_num_in_clust(k)] = mode(ytemp);

    % Assign predicted numeric label to each cluster
    ypredict(cluster==k) = clust_label;

    clear ytemp

    clear clust_label

end

% Assign string label to each numeric label
for i = 1:N
    labels_predict(i) = poss_labels(ypredict(i));
end

% Compute metrics
cond_entropy_clust = -sum(cond_entropy_clust_tmp);

cond_entropy_data = -sum(cond_entropy_data_tmp);

entropy_data = -sum((num_label./N).*log(num_label./N));

entropy_clust = -sum((total_clust./N).*log(total_clust./N));

purity = sum(max_num_in_clust)/N;

homogeneity = 1-(cond_entropy_clust/entropy_data);

completeness = 1-(cond_entropy_data/entropy_clust);

v_measure = 2*((homogeneity*completeness)/(homogeneity+completeness));

NMI = sum(mutual_info)/((entropy_data+entropy_clust)/2);


% For reference, compute CCR
con_mat = confusionmat(ydata',ypredict);

CCR = (sum(diag(con_mat)))/N;