%mobility transfer function
deltat=32;
%identifying top 10% most mobile particles over deltat
H1=circshift(H,-deltat);
H2=H1-H;
H(:,5)=(H2(:,1).^2+H2(:,2).^2).^(0.5);
H(:,6)=H2(:,3)==deltat & H2(:,4)==0;
clear H1 H2
f=H(:,6)==1;
H1=H(f,:);
% H1=sortrows(H1,-5);
% H1=H1(1:(0.1*round(length(H1(:,1)))),:);
A=accumarray(H,1);
a=mean(A);
aa=round(0.1*a);
sigma=10;
r=(0.1):((0.1)*sigma):10;
rmin=1.4*sigma;
Pm_nu=[];
Pm_den=[];
for i=1:1:max(H(:,3))-deltat
    f=H1(:,3)==i;
    B=H1(f,:);
    B=sortrows(B,-5);
    B1=B(1:aa,:);
    B2=B((aa+1):end,:);
    I=randi(length(B2),aa,1);
    B3=B2(I,:);
    f=H1(:,3)==i+deltat;
    C=H1(f,:);
    C=C(1:aa,:);
    C=sortrows(C,-5);
    [~,ia]=setdiff(B1(:,4),C(:,4));
    B1=B1(ia,:);
    [~,ib]=setdiff(C(:,4),B1(:,4));
    C=C(ib,:);
    D1=pdist2(B1(:,1:2),C(:,1:2));
    D1=triu(D1);
    D11=nonzeros(D1);
    J1=histc(D11,r);
    D2=pdist2(B3(:,1:2),C(:,1:2));
    D2=triu(D2);
    D22=nonzeros(D2);
    J2=histc(D22,r);
    Pm_nu=horzcat(Pm_nu,J1);
    Pm_den=horzcat(Pm_den,J2);
end
Pm_nu1=mean(Pm_nu,2);
Pm_den1=mean(Pm_den,2);
M_deltat=trapz(r,Pm_nu1)/trapz(r,Pm_den1);
