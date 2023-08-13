deltat=20;
ta=3*deltat;
sigma=21.7;
a=0.5*sigma;
res=zeros(length(H(:,1)),deltat);
j=1;
for i=round(ta/2-deltat):1:round(ta/2)
    H1=circshift(H,-i);
    H2=circshift(H,i);
    D=H1-H2;
    D(:,5)=(D(:,1).^2+D(:,2).^2).^(0.5);
    f1=(D(:,5)>a);
    f2=D(:,3)==(2*i) & D(:,4)==0;
    f=f1.*f2;
    res(:,j)=f;
    j=j+1;
end

%concentration of excitations

j=j-1;
res=res(:,1:j);
res1=prod(res,2);
H=horzcat(H,res1);
