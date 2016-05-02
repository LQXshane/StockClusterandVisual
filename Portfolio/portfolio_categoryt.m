%%%%%%%%this is optimal portfolio build on industry category
a=zeros(8,1);
for time=1:1000
for i=1:8
a(i)=ceil(5*rand)+(i-1)*5;
end
nowdata=small_set_logreturn(301:600,a);
nowmean=zeros(8,1);
for i=1:8
    nowmean(i)=mean(nowdata(:,i));
end
testdata=small_set_logreturn(1:300,a);
testmean=zeros(8,1);
for i=1:8
    testmean(i)=mean(testdata(:,i));
end
testcov=corrcoef(testdata);
for i=1:8
    for j=i:8
        testcov(j,i)=testcov(i,j);
    end
end
test=Portfolio;
% test = setAssetList(test, name(a));
test = setAssetMoments(test, nowmean, testcov);
test = setDefaultConstraints(test);
plotFrontier(test,20);
hold on
end