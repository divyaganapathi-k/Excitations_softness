%calculation of displacement density at a distance r from the excitation
% HH got from the code excitations
tic
clearvars -except HH
sigmaL=21.7*(1.3); %from previous work's data analysis
d=(0:(0.1)*sigmaL:max(HH(:,1)))';
fac_volume=zeros(20,2);
fac_volume(:,1)=2:2:40;
l=1;
F_ra=zeros(length(d),21);
F_ra(:,1)=d;
for k=1:1:25
    H=HH(:,[1 2 3 4 k]);
    f=H(:,5)~=0;
    h1=sum(f)/length(H(:,5)); % it takes care of average in the denominator
    ta=(k-4)*2;
    ta2=round(ta/2);
    H1=circshift(H,ta2);
    H2=circshift(H,-ta2);
    H3=H2-H1;
    H3(:,5)=(H3(:,1).^2+H3(:,2).^2).^(0.5);
    H3(:,6)=(H3(:,3)==ta & H3(:,4)==0);
    H(:,6)=H3(:,5).*H3(:,6);
    %H(:,6) contains the quantitiy in the summation
    H3(:,3:4)=H2(:,3:4);
    density=[];
    %in order to calculate distances it is done separately for each frame
    %the for loop is to calculate the delta function
    parfor i=1:1:max(H(:,3))
        f=(H(:,3)==i);
        B=H(f,:); %all coordinates at that frame
        f=B(:,5)==1;
        C=B(f,:); % excitation coordinates in ith frame
        for j=1:1:length(C(:,1))
            D=C(j,:);
            E=setdiff(B,D,'rows');
            E(:,7)=E(:,1)-D(1,1);
            E(:,8)=E(:,2)-D(1,2);
            E(:,9)=(E(:,7).^2+E(:,8).^2).^(0.5);
            if length(E(:,1))~=1
                [bincounts,E(:,10)]=histc(E(:,9),d);
                f=E(:,10)==0;
                E(f,:)=[];
                G=accumarray(E(:,10),E(:,6));
                G=G./bincounts(1:length(G));
                G((length(G))+1:numel(d),1)=0;
                density=horzcat(density,G);
            end
        end
    end
    mu=nanmean(density,2);
    if isempty(mu)==0  
        f=(d==10*sigmaL);
        mu=mu-mu(f);
        F_ra(:,l+1)=mu/mu(11);
        fac_volume(l,2)=trapz(d,F_ra(:,l+1));
    end
    l=l+1;
end
toc