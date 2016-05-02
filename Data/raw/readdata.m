%%%%%%this .m file is to load all the csv file of stocks 
%%%%%%clean the data by kicking out missing samples
filename=dir('C:\S&P500\historicaldata');
 data=zeros(1569,437);
 name=[];
 count=0;
 for i=1:471
     datatemp=importdata(filename(i+2).name);
     if length(datatemp.data(:,5))==1569
        name=[name,datatemp.textdata(1)];
        data(:,i)=datatemp.data(:,5);
     end
 end
a=[];
for i=1:471
if find(data(1,i)==0); 
a=[a,i];
end
end
data(:,a)=[];
temp=log(data);
logreturn=zeros(1568,437);
for i=1:437
    logreturn(:,i)=diff(flip(temp(:,i)));
end
a1=corr(logreturn);
temp1=zeros(437,1);
I1=zeros(437,1);
for i=1:437
[temp1(i),I1(i)]=max(a1(:,i));
end
