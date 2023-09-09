% to calculate facilitation volume as a function of time averaged over all
% the excitations at t=ta
tic
clearvars -except HH
col=19; %column no of excitation
H=HH(:,[1 2 3 4 col]);
ta=30;
h1=(sum(H(:,5)))/(length(H(:,5)));
f=H(:,5)==1;
C=H(f,:); % all the excitations
C(:,5)=0;
H2=circshift(H,-(ta/2));
sigmaL=(1.3)*21.7;
d=(0:(0.1)*sigmaL:(max(H(:,1))))';
l=1;
t=zeros(36,1);
j=1;
for k=1:1:4
    for i=j:j:9*j
        t(l,1)=i;
        l=l+1;
    end
        j=10*j;
end
F_ra=zeros(length(d),length(t)+1);
mu=zeros(length(d),length(t)+1);
mu(:,1)=d;
F_ra(:,1)=d;
fac_vol=zeros(length(t),2);
fac_vol(:,1)=t;
for i=1:1:length(t)
    H1=circshift(H,-t(i));
    H3=H1(:,1:4)-H2(:,1:4);
    H3(:,5)=(H3(:,1).^2+H3(:,2).^2).^(0.5);
    f=H3(:,3)==(t(i)-(ta/2)) & H3(:,4)==0;
    R=f.*H3(:,5);
    clear f H1 H3
    density=[];
%     f2=H(:,3)==i;
%     B=H(f2,1:2);
    parfor j=1:1:max(H(:,3))
        f=H(:,3)==j;
        A=horzcat(H(f,1:4),R(f));
        f=C(:,3)==j;
        B=C(f,1:4);
        if isempty(B)==0
            for k=1:1:length(B(:,1))
                D=B(k,:);
                [~,ia]=setdiff(A(:,1:4),D(:,1:4),'rows');
                E=A(ia,[1 2 5]);
                E(:,1)=E(:,1)-D(1,1);
                E(:,2)=E(:,2)-D(1,2);
                E(:,4)=(E(:,1).^2+E(:,2).^2).^(0.5);
                [bincounts,E(:,5)]=histc(E(:,4),d);
                f=E(:,5)==0;
                E(f,:)=[];
                G=accumarray(E(:,5),E(:,3));
                G=G./bincounts(1:length(G));
                G((length(G))+1:numel(d),1)=0;
                density=horzcat(density,G);
            end
        else
            continue
        end
    end
    mu(:,i+1)=nanmean(density,2);
    f=(d==10*sigmaL);
    mu(:,i+1)=mu(:,i+1)-mu(f,i+1);
    F_ra(:,i+1)=mu(:,i+1)/mu(11,i+1);
    fac_vol(i,2)=trapz(d,F_ra(:,i+1)); 
end
toc
F_ra1=F_ra(11:101,:);
fac_vol1(:,1)=t;
for i=1:1:36
    fac_vol1(i,2)=trapz(d(11:101,1),F_ra1(:,i+1));
end