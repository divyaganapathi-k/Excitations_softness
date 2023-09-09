% clearvars -except H
% H1 is the track of required small particle coordinates dedrifted
% f=H(:,5)<=400;
% A=H(f,4);
% binranges=1:max(A);
% B=histc(A,binranges);
% f=(B>=10);
% C=nonzeros(binranges'.*f);
% D=ismember(H(:,4),A);
% H1=H(D,:);
% % H2 is the track of required big particle coordinates dedrifted
% H2=setdiff(H,H1,'rows');
% clearvars -except H H1 H2
% f=(data(:,5)<0.2);
% data=data(f,:);
% H1=data(:,[1 2 9]);
% H1=pos_lst(:,[1 2 5]);
% clearvars -except H1 time
% pos_lst=pos_lst(:,[1 2 5]);
% n=max(pos_lst(:,5));
% deltat=100;
sigma=18; %big particle diameter
mu=(0.4)*sigma:(0.1)*sigma:(5.0)*sigma; %probing radius
l=length(mu);
k=140;
for j=2:1:19
    radial_density=[];
    pos_lst=[];
    load(strcat('F:\3D_slices_new\1_6below_',num2str(j)));
    parfor i=1:1:max(pos_lst(:,5))
        f=(pos_lst(:,5)==i);
        A1=pos_lst(f,:);
        B1=pdist2(A1(:,1:2),A1(:,1:2),'euclidean','Smallest',k); 
    %     f=(H2(:,3)==i);
    %     A2=H2(f,:);
    %     B2=pdist2(A2(:,1:2),A1(:,1:2),'euclidean','Smallest',k); 
        radial_density_frame=A1;
        % first 47 values calculated from the small particles around the
        % particle of interest X belonging to s
        for l=1:1:length(mu)
            f=(B1<=mu(l) & B1~=0);
            f=double(f);
            f(f==0)=NaN;
            B11=B1.*f;
            B11=exp(-((B11-mu(l))./((0.1)*sigma)).^2);
            C=nansum(B11,1);
            radial_density_frame=horzcat(radial_density_frame,C');
        end
        % last 47 values calculated from the big particles around the
        % particle of interest  X belonging to l
    %     for j=1:1:length(mu)
    %         f=(B2<=mu(j) & B2~=0);
    %         f=double(f);
    %         f(f==0)=NaN;
    %         B22=B2.*f;
    %         B22=exp(-((B22-mu(j))./((0.1)*sigma)).^2);
    %         C=nansum(B22,1);
    %         radial_density_frame=horzcat(radial_density_frame,C');
    %     end
        radial_density=vertcat(radial_density,radial_density_frame);
    end
    save(strcat('F:\3D_slices_new\radial_density_1_',num2str(j)));
end
% radial_density has particle coordinates, time, particle id, size(RG), 94
% attributes to be used for machine learning