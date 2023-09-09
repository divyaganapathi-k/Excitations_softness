phop_all=sortrows(phop_all,[5,4]);
B=unique(phop_all(:,5));
phop=[];
% order=1;
for i=1:1:length(B)
    f=phop_all(:,5)==B(i);
    C=phop_all(f,:);
    C(:,6)=smooth(C(:,1),10);
%     p=polyfit(C(:,4),C(:,6),order);
%     C(:,7)=C(:,6)-polyval(p,C(:,4));
    phop=vertcat(phop,C);
end
A=accumarray(phop(:,5),phop(:,6),[],@min);
phop(:,6)=phop(:,6)-A(phop(:,5));