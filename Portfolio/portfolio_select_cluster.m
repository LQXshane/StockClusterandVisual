%%%%%%%%%%%%%this file is used for generate optimal portfolio for cluster
%%%%%%%%%%%%%selecting
importdata('sp.mat');
a=[];
for time=1:1000
for i=1:8
    if length(Dnumber{i})~=0;
        a=[a,Dnumber{1,i}(1,ceil(length(Dnumber{i})*rand))];
    end
end
k=length(a);
nowdata=small_set_logreturn(301:600,a);
nowmean=zeros(k,1);
for i=1:k
    nowmean(i)=mean(nowdata(:,i));
end
testdata=small_set_logreturn(1:300,a);
testmean=zeros(k,1);
for i=1:k
    testmean(i)=mean(testdata(:,i));
end
testcov=corrcoef(testdata);
for i=1:k
    for j=i:k
        testcov(j,i)=testcov(i,j);
    end
end
test=Portfolio;
% test = setAssetList(test, name(a));
test = setAssetMoments(test, nowmean, testcov);
test = setDefaultConstraints(test);
plotFrontier(test,20);
hold on
a=[];
end
