%instantaneous phop distribution subtracting the base value of each
% %trajectory from the minimum number
% clearvars -except phop_all
% phop_all=sortrows(phop_all,[5 4]);
% A=unique(phop_all(:,5));
% for i=1:1:length(A)
%     f=phop_all(:,5)==A(i);
%     phop=phop_all(f,:);
%     phop1=sgolayfilt();
% end
%above for loop not needed for calculating histogram of phop



%Part I - histogram of instantaneous phop values to see the slope
%transition at higher values
% % clearvars -except phop_all
% % A=accumarray(phop_all(:,5),1);
% % f=find(A>25);
% % Lia=ismember(phop_all(:,5),f);
% % phop_all1=phop_all(Lia,:);
% phop_all=sortrows(phop_all,[5 4]);
% % f=phop_all(:,4)<=8000;
% % phop_all1=phop_all(f,:);
% phop_all1=phop_all;
% B=accumarray(phop_all1(:,5),phop_all1(:,1),[],@min);
% phop=phop_all1(:,1)-B(phop_all1(:,5));
% phop=horzcat(phop,phop_all1(:,2:5));
% x=(0.0001:0.0005:0.2)';
% H=histc(phop(:,1),x);

% histogram of residence time distributions
% clearvars -except phop_all
% phop=phop_all;


%Part II - residence time distributions
%  pks=[]; pks1=[];
%     [pks(:,1),pks(:,2)]=findpeaks(hop,'minpeakheight',0.02);
% clearvars -except phop_all
% y=(0.005:0.005:0.5)';
% res_time=zeros(length(y),1);
%type I
% for i=1:1:length(y)
%     f=phop(:,1)>y(i);
%     phop1=phop(f,[1 4 5]);
%     phop2=circshift(phop1,1);
%     A=phop1-phop2;
%     f=A(:,3)==0;
%     A=A(f,2);
%     res_time(i)=mean(A);
% end
%the above for loop did not work

%type II
% smooth phop profiles
% A=unique(phop_all(:,5));
% phop_all=sortrows(phop_all,[5 4]);
% B=accumarray(phop_all(:,5),phop_all(:,1),[],@min);
% phop_all1=phop_all(:,1)-B(phop_all(:,5));
% phop_all1=horzcat(phop_all1,phop_all(:,2:5));
% hop_all=[];
% for i=1:1:length(A)
%     f=phop_all1(:,5)==A(i);
%     hop=smooth(phop_all1(f,1),10);
%     hop_all=vertcat(hop_all,hop);
% end
% hop_all=horzcat(hop_all,phop_all(:,4:5));
% hop_all=phop_all(:,[1 4 5]);
% hop_all=sortrows(hop_all,[3 2]);
phop=[];
for i=1:1:length(y)
    [~,pks]=findpeaks(phop_all1(:,1),'minpeakheight',y(i));
    phop=phop_all1(pks,:);
    phop1=circshift(phop,1);
    phop2=phop-phop1;
    f=phop2(:,5)==0;
    res_time(i,1)=mean(phop2(f,4));
end