% % clearvars -except HH
tic
H1=[];
parfor i=1:1:max(H(:,4))
    f=H(:,4)==i;
    A=H(f,:);
    B1=smooth(A(:,1),10);
    B2=smooth(A(:,2),10);
    C=horzcat(B1,B2,A(:,3:4));
    H1=vertcat(H1,C);
end
toc
HH=H1;
H=H1;
clear H1
% HH=HH(:,1:4);
% H=HH;
tic
sigmas=21.7; %from previous results of mosaics
a=(0.5)*sigmas; %excitation length
res=[];
for k=2:2:220
    deltat=k;
    ta=(3)*deltat;
    B=round(ta/2-deltat):1:round(ta/2);
    if isempty(res)==0
        [C,ia,~]=intersect(A,B);
         res=res(:,ia);
         ti=max(C)+1;
    else
        ti=round(ta/2-deltat);
    end
    parfor i=ti:1:round(ta/2)
        H1=circshift(H,-i);
        H2=circshift(H,i);
        D=H1-H2;
        D(:,5)=((D(:,1).^2)+(D(:,2).^2)).^(0.5);
        f1=(D(:,5)>=(a) & D(:,5)<((3)*a));
        f2=D(:,3)==(2*i) & D(:,4)==0;
        f=f1.*f2;
        res=horzcat(res,f);
    end
    A=round(ta/2-deltat):1:round(ta/2);
    res1=prod(res,2);
    HH=horzcat(HH,res1);
end
toc
% % %concentration of excitations
% j=j-1;
% res=res(:,1:j);
% res1=prod(res,2);
% H=horzcat(H,res1); 

% % [J,~,~]=unique(I(:,1));
% % M=HH(J,4);
% % % [N,ia,~]=unique(M);f=find(HH(:,5:end));
% f=find(HH(:,5:end));
% [I(:,1),I(:,2)]=ind2sub(size(HH(:,5:end)),f);
% I=sortrows(I,1);
% [J,ia,~]=unique(I(:,1));
% J(:,2)=I(ia,2);
% J(:,3)=HH(J(:,1),4);
% K=accumarray(J(:,3),J(:,2),[],@min);
% K1=nonzeros(K);
% a=1:1:((length(HH(1,:)))-4);
% L=histc(K1,a);
% % K=I(ia,2);
% % a=1:1:((length(HH(1,:)))-4);
% % L=histc(K,a);
% % hist(K)