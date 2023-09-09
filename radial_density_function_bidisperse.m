% use just the coordinate files to define radial density not track files
% for a bidisperse system it is as follows
pos_lst=pos_lst(:,[3 1 2 4]);
clearvars -except pos_lst
% pos_lst=pos_lst(:,2:end);
n=max(pos_lst(:,4));
sigma=21.7; %big particle diameter as used in Yodh's paper *1.3
mu=(0.4)*sigma:(0.1)*sigma:(5.0)*sigma; %probing radius
l=length(mu);
radial_density=[];
parfor i=1:1:n
    f=(pos_lst(:,4)==i);
    A=pos_lst(f,:);
    radial_density_frame=A;
    B=pdist2(A(:,2:3),A(:,2:3));
    % first 47 values calculated from the small particles around the
    % particle of interest X belonging to s
    f=A(:,1)<=400;
    F1=repmat(f,1,length(A(:,1)));
    C=B.*F1;
    C(C==0)=NaN;
    for j=1:1:length(mu)
        E=C-mu(1,j);
        E=E/((0.1)*sigma);
        E=E.^2;
        E=-E;
        E=exp(E);
        F=nansum(E,1);
        radial_density_frame=horzcat(radial_density_frame,F');
    end
    % last 47 values calculated from the big particles around the
    % particle of interest  X belonging to l
    F2=~F1;
    D=B.*F2;
    D(D==0)=NaN;
    for j=1:1:length(mu)
        G=D-mu(1,j);
        G=G/((0.1)*sigma);
        G=G.^2;
        G=-G;
        G=exp(G);
        H=nansum(G,1);
        radial_density_frame=horzcat(radial_density_frame,H');
    end
    radial_density=vertcat(radial_density,radial_density_frame);
end
% radial_density has particle coordinates, time, particle id, size(RG), 94
% attributes to be used for machine learning