%calculation of displacement density at a distance r from the excitation
HH=accumarray(H(:,3),H(:,5));
A=accumarray(H(:,3),1);
HH1=HH./A;
h1=mean(HH1);
ta2=10;
H1=circshift(H,ta2);
H2=circshift(H,-ta2);
H3=H1-H2;
H3(:,5)=(H3(:,1).^2+H3(:,2).^2).^(0.5);
H3(:,6)=(H3(:,3)==ta & H3(:,4)==0);
H(:,6)=H3(:,5).*H3(:,6);
a1=10; a2=20; b1=10; b2=20;
d=0:(0.2)*sigma:100;
density=[];
for i=1:1:max(H(:,3))
    f=H(:,3)==i;
    B=H(f,:);
    f=B(:,5)==1;
    C=B(f,:);
    for j=1:1:length(C(:,1))
        D=C(j,:);
        E=setdiff(D,B,'rows');
        E(:,7)=E(:,1)-D(1,1);
        E(:,8)=E(:,2)-D(2,1);
        E(:,9)=(E(:,6).^2+E(:,7).^2).^(0.5);
        c1=abs(C(j,1)-a1); c2=abs(C(j,1)-a2); c3=abs(C(j,2)-b1); c4=abs(C(j,2)-b2);
        d1=min(c1,c2); d2=min(c3,c4);
        d3=min(d1,d2);
        binranges=0:(0.2)*sigma:d3;
        [bincounts,E(:,10)]=histc(E(:,9),binranges);
        F=accumarray(E(:,10),E(:,6));
        F(numel(d))=0;
        density=horzcat(density,F);
    end
end
den_exci=mean(nonzeros(density),2);

%to calculate mu_infinity
f=H3(:,6)~=0;
G=H3(f,:);
I=accumarray(G(:,4),G(:,5),[],@mean);
mu_inf=mean(I);
clear G

%calculation of spatial extent of excitation
%g(r) to be borrowed from an earlier calculation
mu1=((den_exci)./gr);
mu=(mu1/mu_inf)-1;
