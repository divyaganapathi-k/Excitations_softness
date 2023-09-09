clearvars -except HH
K2=[];
a=1:120:max(HH(:,3));
for i=1:1:(length(a)-1)
    f=HH(:,3)>=a(i) & HH(:,3)<a(i+1);
    HH1=HH(f,:);
    f=find(HH1(:,5:end));
    [I(:,1),I(:,2)]=ind2sub(size(HH1(:,5:end)),f);
    I=sortrows(I,1);
    [J,ia,~]=unique(I(:,1));
    J(:,2)=I(ia,2);
    J(:,3)=HH1(J(:,1),4);
%     K=accumarray(J(:,3),J(:,2),[],@min);
%     K1=nonzeros(K);
%     K1(:,2)=unique(J(:,3));
    J=sortrows(J,[3 2]);
    [~,ia,~]=unique(J(:,3));
    K1=(J(ia,[2 3]));
    K2=vertcat(K2,K1);
    I=[]; J=[]; K=[]; K1=[];
end
% f=find(HH(:,5:end));
% [I(:,1),I(:,2)]=ind2sub(size(HH(:,5:end)),f);
% I=sortrows(I,1);
% [J,ia,~]=unique(I(:,1));
% J(:,2)=I(ia,2);
% J(:,3)=HH(J(:,1),4);
% K=accumarray(J(:,3),J(:,2),[],@min);
% K1=nonzeros(K);
% % K1(:,2)=unique(J(:,3));
% % K2=vertcat(K2,K1);
% K2 contatins lowest excitation time and particle id
K2=sortrows(K2,2);
K3=accumarray(K2(:,2),K2(:,1),[],@min);
K4=K2(:,1)-(5)*K3(K2(:,2));
f=find(K4<0);
K5=K2(f,:);
K5=nonzeros(K5(:,1));
a=1:1:((length(HH1(1,:)))-4);
L=histc(K5(:,1),a);
L=L/sum(L);