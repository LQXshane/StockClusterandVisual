%% RMT preprocess by Ganyu
%%%%%%%%%%%%%%vmax is the eigenvector corresponding to the largest eienvalues
%%%%%%%%%%%%%%this file is to remove the whole market impact on each stocks
n=437;
d=1568;
vmax=Vec(:,n);
G=zeros(d,1);
for i=1:d
    G(i)=vmax'*logreturn(i,:)';
end

newlogreturn=zeros(d,n);
for i=1:n
[B,BINT,R] = regress(logreturn(:,i),G);
newlogreturn(:,i)=R;
end

newcorr=corrcoef(newlogreturn);