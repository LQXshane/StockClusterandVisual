%%%%%%%%%%%this file is to calculate optimal portfolio
%%%%%%%%%%%for prediction in 2011 by using stock price in 2010
%%%%%%%%%%%and the true optimal portfolio of 2011


past=small_set_logreturn(1:300,:);
now=small_set_logreturn(301:600,:);
nowmean=zeros(40,1);
pastmean=zeros(40,1);
for i=1:40
    nowmean(i)=mean(now(:,i));
    pastmean(i)=mean(past(:,i));
end
Cnow=corrcoef(now);
Cpast=corrcoef(past);
for i=1:40
    for j=i:40
        Cnow(j,i)=Cnow(i,j);
        Cpast(j,i)=Cpast(i,j);
    end
end
ppast=Portfolio;
% ppast = setAssetList(ppast, name);
pnow=Portfolio;
% pnow = setAssetList(pnow, name);
figure(1)
pnow = setAssetMoments(pnow, nowmean, Cnow);
pnow = setDefaultConstraints(pnow);
plotFrontier(pnow,20);
hold on
ppast = setAssetMoments(ppast, nowmean, Cpast);
ppast = setDefaultConstraints(ppast);
plotFrontier(ppast,20);


