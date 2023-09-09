% clearvars -except soft_cont excit_cont
C=soft_cont>30;
D=excit_cont>=5;
C=C.';
D=D.';
A=circshift(C,1);
B=circshift(D,1);
C1=C-A;
D1=D-B;
%rising edge of excitation and falling edge of soft
f1=C1==-1;
f2=D1==-1;
pdeltat=[];
for i=1:1:length(C(1,:))
    G=find(f1(:,i));
    H=find(f2(:,i));
%     if C(1,i)==1 && sum(C(:,i))>7000
%        H=vertcat(H,1); 
%     end
    for j=1:1:length(H)
        c=H(j,1)-G;
        f=c>0;
        c=c(f,:);
        pdeltat=vertcat(pdeltat,min(c));
    end
end
% t=5:5:1000;
% pdt=histc(t,pdeltat);