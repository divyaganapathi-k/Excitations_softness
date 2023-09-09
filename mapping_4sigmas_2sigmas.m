n=1:1:735;
[A(:,1), A(:,2)]=ind2sub([35 21],n);
A(:,3:4)=ceil(A(:,1:2)/2);
A(:,5)=sub2ind([18 11],A(:,3),A(:,4));
excit_cont1=zeros(4,length(av_soft_cont),max(A(:,5)));
hard_cont1=zeros(4,length(av_soft_cont),max(A(:,5)));
soft_cont1=zeros(4,length(av_soft_cont),max(A(:,5)));
av_soft_cont1=zeros(4,length(av_soft_cont),max(A(:,5)));
for i=1:1:max(A(:,5))
    f=A(:,5)==i;
    if sum(f)==4
        excit_cont1(:,:,i)=excit_cont(f,:);
        soft_cont1(:,:,i)=soft_cont(f,:);
        hard_cont1(:,:,i)=hard_cont(f,:);
        av_soft_cont1(:,:,i)=av_soft_cont(f,:);
    elseif sum(f)<4
        x=NaN(4-sum(f),length(av_soft_cont));
        excit_cont1(:,:,i)=vertcat(excit_cont(f,:),x);
        soft_cont1(:,:,i)=vertcat(soft_cont(f,:),x);
        hard_cont1(:,:,i)=vertcat(hard_cont(f,:),x);
        av_soft_cont1(:,:,i)=vertcat(av_soft_cont(f,:),x);
    end
end
a=70;
CC(:,1)=(1:1:length(av_soft_cont))';
CC(:,2:5)=(soft_cont1(:,:,a))';
CC(:,6:9)=(hard_cont1(:,:,a))';
CC(:,10:13)=(excit_cont1(:,:,a))';
CC(:,14:17)=(av_soft_cont1(:,:,a))';
CC(:,2:9)=double(CC(:,2:9)>=50);
CC(:,10:13)=double(CC(:,10:13)>=2);
CC=CC(:,[1 2 10 6 14 3 11 7 15 4 12 8 16 5 13 9 17]);

% C(:,1)=sum(CC(:,2:5),2);
% C(:,2)=sum(CC(:,6:9),2);
% C(:,3)=sum(CC(:,10:13),2);
% C(:,4)=mean(CC(:,14:17),2);
% C(:,1)=double(C(:,1)>=200);
% C(:,2)=double(C(:,2)>=200);
% C(:,3)=double(C(:,3)>=5);