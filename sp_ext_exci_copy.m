%calculation of displacement density at a distance r from the excitation
% HH got from the code excitations
tic
% % % clearvars -except HH gr
% col=15; %column corresponding to ta in HH
% %no is 19 for 5 frames per sec and 16 for 4 frames per sec
% H=HH(:,[1 2 3 4 col]);
% H=sortrows(H,[4 3]);
clearvars -except H gr
% H=horzcat(H,HH(:,col));
% HH1=accumarray(H(:,3),H(:,5));
% A=accumarray(H(:,3),1);
% HH2=HH1./A;
% h1=mean(HH2); % it takes care of average in the denominator
f=H(:,5)~=0;
h1=sum(f)/length(H(:,5)); % it takes care of average in the denominator
sigmaL=21.7*(1.3); %from previous work's data analysis
ta=30;
ta2=round(ta/2);
H1=circshift(H,ta2);
H2=circshift(H,-ta2);
H3=H2-H1;
H3(:,5)=(H3(:,1).^2+H3(:,2).^2).^(0.5);
H3(:,6)=(H3(:,3)==ta & H3(:,4)==0);
H(:,6)=H3(:,5).*H3(:,6);
%H(:,6) contains the quantitiy in the summation
H3(:,3:4)=H2(:,3:4);
% a1=min(H(:,1)); a2=max(H(:,1)); b1=min(H(:,2)); b2=max(H(:,2));
d=0:(0.1)*sigmaL:(1.5)*max(H(:,1));
density=[];
% %in order to calculate distances it is done separately for each frame
% %the for loop is to calculate the delta function
for i=1:1:max(H(:,3))
    f=(H(:,3)==i);
    B=H(f,:); %all coordinates at that frame
    f=B(:,5)==1;
    C=B(f,:); % excitation coordinates in ith frame
    D=pdist2(B(:,1:2),C(:,1:2));
        if isempty(C)==0
            [bincounts,ind]=histc(D,d);
            G=zeros(length(d),size(D,2));
            for j=1:1:size(D,2)
                J=accumarray(ind(:,j),B(:,6));
                J((length(J))+1:numel(d),1)=0;
                G(:,j)=J;
                J=[];
            end
            G=G./bincounts;
            density=horzcat(density,G);
        end    
end
mu=nanmean(density,2);
% mu=mu/h1;
%to calculate mu_infinity as a function of distance
f=H3(:,6)~=0;
J=H3(f,:);
I=accumarray(J(:,4),J(:,5),[],@mean);
I=nonzeros(I);
mu_inf=mean(I);
% clear J I 

toc
% d1=(d*(0.1))';
%calculation of spatial extent of excitation
%g(r) to be borrowed from an earlier calculation
% mu1=sigmaL*(mu./d');
% mu1=(mu((1:(length(gr(:,2)))),:))./gr(:,2);
% mu1=(mu1./gr(:,2));
% F_ra(:,1)=gr(:,1);
F_ra(:,1)=d';
% F_ra(:,2)=(mu((1:(length(gr(:,2)))),:)/mu_inf)-1;
F_ra(:,2)=(mu/mu_inf)-1;
% F_ra(:,2)=F_ra(:,2)./gn(:,2);
% % F_ra(:,2)=F_ra(:,2)./d1(1:length(F_ra(:,2)),1);
% f=F_ra(:,1)==10*1.3*21.7;
% F_ra=F_ra(1:f,:);