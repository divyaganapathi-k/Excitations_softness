%mobility transfer function
% it is separate for small and large particles
tic
clearvars -except S
%S contains dedrifted coordinates plus the size of the particle in the last
%column
%fifth column of H2 is the size of the particles
%identifying only small particles
f=S(:,5)<=450;
H=S(f,:);
deltat=1;
fac=1;
sigma=21.7*fac;
rmin=56.42;
% r=((0.1):((0.1)*sigma):max(S(:,1)))';
s=((0.1):((0.1)*sigma):rmin)';
Mf=[];
M_deltat=[];
k=1;
bb=0;
for l=1:1:4
    for j=deltat:deltat:9*deltat
%     for j=5:5:2000   
        %identifying top 10% most mobile particles over deltat
        H1=circshift(H,-j);
        H2=H1-H;
        H(:,6)=(H2(:,1).^2+H2(:,2).^2).^(0.5);
        H(:,7)=H2(:,3)==j & H2(:,4)==0;
        clear H1 H2
        f=H(:,7)==1;
        H1=H(f,:);
        % H1=sortrows(H1,-5);
        % H1=H1(1:(0.1*round(length(H1(:,1)))),:);
        A=accumarray(H(:,3),1);
        a=mean(A);
        aa=round(0.1*a); %number of most mobile particles
        Pm_nu=[];
        Pm_den=[];
        parfor i=1:1:max(H1(:,3))-j-1
            f=H1(:,3)==i;
            B=H1(f,:);
            B=sortrows(B,-6);
            if length(B(:,1))>aa
                B1=B(1:aa,:);
                B2=B((aa+1):end,:);
                if length(B2(:,1))>1*aa
                    B2=sortrows(B2,6);
                    B2=B2(1:1*aa,:);
                    I=randperm(length(B2),aa);
                    B3=B2(I,:);
                    f=H1(:,3)==i+1;
                    C=H1(f,:);
                    C=sortrows(C,-6);
                    C=C(1:aa,:);
                    %eliminating particles which are mobile in both time intervals
                    [~,ia]=setdiff(B1(:,4),C(:,4));
                    [~,ib]=setdiff(C(:,4),B1(:,4));
                    B1=B1(ia,:);
                    C=C(ib,:);
                    % B11 and C11 are the required coordinates for the numerator
                    D1=pdist2(B1(:,1:2),C(:,1:2),'euclidean','Smallest',1);
                    J1=((histc(D1,s))');
                    J1=J1/length(D1);
                    D2=pdist2(B3(:,1:2),C(:,1:2),'euclidean','Smallest',1);
                    J2=((histc(D2,s))');
                    J2=J2/length(D2);
                    Pm_nu=horzcat(Pm_nu,J1);
                    Pm_den=horzcat(Pm_den,J2);
                else
                    continue
                end
            else 
                continue
            end
        end 
        Pm_nu1=nanmean(Pm_nu,2);
        Pm_den1=nanmean(Pm_den,2);
        M_deltat(k,1)=j;
        if isempty(Pm_nu1)==0
            M_deltat(k,2)=trapz(s,Pm_nu1)/trapz(s,Pm_den1);
            Mf_frame=horzcat(Pm_nu1,Pm_den1,s);
            Mf_frame(:,4)=j;
            Mf=vertcat(Mf,Mf_frame);
            k=k+1;
        else 
            bb=1;
            break;
        end
    end
    if bb==1
        break
    else
        deltat=10*deltat;
    end     
end
toc
A=unique(Mf(:,4));
M_deltat1=[];
for i=1:1:length(A)
    f=Mf(:,4)==A(i);
    Mf_frame=Mf(f,:);
    M_deltat1(i,1)=A(i);
    M_deltat1(i,2)=(trapz(s,Mf_frame((length(s)),1)))/(trapz(s,Mf_frame((length(s)),2)));
end