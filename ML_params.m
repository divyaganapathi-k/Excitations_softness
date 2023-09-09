% clearvars -except phop_all
% phop_all=sortrows(phop_all,[5,4]);
% y=0.0001:0.0005:1.2;
% phop=phop_all;
% % f=phop_all(:,4)<=6500;
% % phop=phop_all(f,:);
% t_res_av=zeros(length(y),1);
% % A=accumarray(phop(:,5),phop(:,1),[],@min);
% % phop(:,6)=phop(:,1)-A(phop(:,5));
% B=unique(phop(:,5));
% phop1=[];
% for i=1:1:length(B)
%     f=phop(:,5)==B(i);
%     C=phop(f,:);
%     C(:,6)=smooth(C(:,1));
%     phop1=vertcat(phop1,C);
% end
% phop=[];
% phop=phop1;
% phop1=[];
phop_all=sortrows(phop_all,[5,4]);
phop=phop_all;
A=accumarray(phop(:,5),phop(:,1),[],@min);
phop(:,6)=phop(:,1)-A(phop(:,5));
A=accumarray(phop(:,5),1);
f=find(A>300);
Lia=ismember(phop(:,5),f);
f=find(Lia);
phop11=phop(f,:);
phop1=phop11(:,[6 4 5]);
% [~,pks]=findpeaks(phop11(:,6));
% phop1=phop11(pks,[6 4 5]);
y=0.0001:0.0001:0.1;
for i=1:1:length(y)
    f=phop1(:,1)>=y(i);
    phop2=phop1(f,:);
    phop3=circshift(phop2,1);
    phop4=phop2-phop3;
    f=phop4(:,3)==0;
    t_res_av(i,1)=mean(phop4(f,2));
end