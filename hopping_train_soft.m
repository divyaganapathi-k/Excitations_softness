% to find the soft particles in the system
clearvars -except H
% H1 is the track of required small/big particle coordinates dedrifted
f=H(:,5)<=400;
A=H(f,4);
binranges=1:max(A);
B=histc(A,binranges);
f=(B>=10);
C=nonzeros(binranges'.*f);
D=ismember(H(:,4),A);
H1=H(D,:);
clearvars -except H H1
n=max(H1(:,3));
deltat=2;
phop_all=[];
for i=1+(deltat/2):1:(n-(deltat/2))
    %i defines t
    %identification of tracks that stayed for deltat
    f1=(H1(:,3)==(i-(deltat/2)));
    T1=H1(f1,4);
    f2=(H1(:,3)==(i+(deltat/2)));
    T2=H1(f2,4);
    T=intersect(T1,T2);
    f=ismember(H1(:,4),T);
    req_tracks=H1(f,:);
    clearvars -except req_tracks H1 H n deltat i phop_all
    %calculating hop for each particle at ith frame
    %period of A
    f=(req_tracks(:,3)>=(i-(deltat/2)) & req_tracks(:,3)<=i);
    req_tracks1=req_tracks(f,:);
    %period of B
    f=(req_tracks(:,3)>=i & req_tracks(:,3)<=(i+(deltat/2)));
    req_tracks2=req_tracks(f,:);
    ria_mean1=accumarray(req_tracks1(:,4),req_tracks1(:,1),[],@mean);
    ria_mean2=accumarray(req_tracks1(:,4),req_tracks1(:,2),[],@mean);
    rib_mean1=accumarray(req_tracks2(:,4),req_tracks2(:,1),[],@mean);
    rib_mean2=accumarray(req_tracks2(:,4),req_tracks2(:,2),[],@mean);
    req_tracks1(:,6)=req_tracks1(:,1)-rib_mean1(req_tracks1(:,4));
    req_tracks1(:,7)=req_tracks1(:,2)-rib_mean2(req_tracks1(:,4));
    req_tracks2(:,6)=req_tracks2(:,1)-ria_mean1(req_tracks2(:,4));
    req_tracks2(:,7)=req_tracks2(:,2)-ria_mean2(req_tracks2(:,4));
    clear ria_mean1 ria_mean2 rib_mean1 rib_mean2
    req_tracks1(:,8)=(req_tracks1(:,6).^2)+(req_tracks1(:,7).^2);
    req_tracks2(:,8)=(req_tracks2(:,6).^2)+(req_tracks2(:,7).^2);
    phop1=accumarray(req_tracks1(:,4),req_tracks1(:,8),[],@mean);
    phop2=accumarray(req_tracks2(:,4),req_tracks2(:,8),[],@mean);
    phop=(phop1.*phop2).^(0.5);
    f=unique(req_tracks(:,4));
    phop=phop(f);
    f=(req_tracks(:,3)==i);
    req_coordinates=req_tracks(f,:);
    phop=horzcat(phop, req_coordinates);
    phop_all=vertcat(phop_all,phop);
end
phop_all(:,1)=phop_all(:,1)/((sigma)^2);