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
    J(:,3:4)=HH1(J(:,1),3:4);
    K=accumarray(J(:,4),J(:,2),[],@min);
    K1=nonzeros(K);
    K1(:,2)=unique(J(:,4));
    [C,~,ib]=intersect(K1,J(:,[2 4]),'rows');
    K11=horzcat(C,J(ib,3));
    K2=vertcat(K2,K11);
    I=[]; J=[]; K=[]; K1=[];
end
% K2 contains at 1st column time taken for the particle to get excited and
% 3rd column the time at which the particle is excited and 2nd column
% particle id
%now again filtering the excitations
K2=sortrows(K2,2);
K3=accumarray(K2(:,2),K2(:,1),[],@min);
K4=K2(:,1)-(2)*K3(K2(:,2));
f=find(K4<0);
K5=K2(f,:);
% K5=nonzeros(K5(:,1));
% K5 now contains the required excitations on which faciliatation volume
% can be calculated so that the time is minimized


%PART-II
%calculation of facilation volume as a function of time
% HH got from the code excitations
tic
clearvars -except HH K5
sigmaL=21.7*(1.3); %from previous work's data analysis
d=(0:(0.1)*sigmaL:max(HH(:,1)))';
fac_volume=zeros(20,2);
fac_volume(:,1)=2:2:40;
l=1;
F_ra=zeros(length(d),21);
F_ra(:,1)=d;
H=HH(:,1:4);
% HH is not all required for the calculation, all the required excitations
% are in K5 only
a=unique(1);
for k=5:1:98
    f=K5(:,1)==k;
    h1=sum(f)/length(H(:,1)); % it takes care of average in the denominator
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
    f=K5(:,1)==k;
    K=K5(f,:);
    %in order to calculate distances it is done separately for each frame
    %the for loop is to calculate the delta function
    parfor i=1:1:max(H(:,3))
        f=K(:,3)==i;
        K1=K(f,:); %excitation of the ith frame
        if isempty(K1)==0
            f=(H(:,3)==i);
            B=H(f,:); %all coordinates at that frame 
            for j=1:1:length(K1(:,1))
                f=(B(:,4)==K1(j,2));
                D=B(f,:);
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
        else 
            continue
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