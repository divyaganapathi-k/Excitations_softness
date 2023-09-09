clearvars -except phop_all H R radial_density req_coord_hard
% phop_all(:,1)=ceil(phop_all(:,1)*10000)/10000;
% phop_all(:,2)=ceil(phop_all(:,2)*10000)/10000;
% H(:,1)=ceil(H(:,1)*10000)/10000;
% H(:,2)=ceil(H(:,2)*10000)/10000;
% R(:,1)=ceil(R(:,1)*10000)/10000;
% R(:,2)=ceil(R(:,2)*10000)/10000;
% radial_density(:,1)=ceil(radial_density(:,1)*10000)/10000;
% radial_density(:,2)=ceil(radial_density(:,2)*10000)/10000;
deltat=32;
A=circshift(phop_all(:,3),1);
B=circshift(phop_all(:,3),-1);
A=phop_all(:,3)-A;
B=B-phop_all(:,3);
phop_all(:,6)=(A+B)==2;
[pks(:,1),pks(:,2)]=findpeaks(phop_all(:,1));
pks(:,2)=pks(:,2).*phop_all(pks(:,2),6);
pks1=nonzeros(pks(:,2));
phop_all1=phop_all(pks1,:);
f=phop_all1(:,5)>0.6;
hops=phop_all1(f,:);
hops=sortrows(hops,-5);
hops(:,7)=hops(:,3)-deltat;
f=hops(:,7)<0;
hops(f,:)=[]; %avoiding negative time numbers
[~,ia,ib]=intersect(hops(:,[7 4]),H(:,3:4),'rows'); % to get deltat
p_soft=horzcat(hops(ia,1:5),H(ib,:));
%all the peaks having coordinates at a prior time delta t
p_soft=sortrows(p_soft,[4 3]);
A=accumarray(p_soft(:,4),p_soft(:,5),[],@max);
highest_peak(:,1)=find(A);
highest_peak(:,2)=A(highest_peak(:,1));
% the highest peak containing every unique coordinate
[C,~,ib]=intersect(highest_peak,p_soft(:,4:5),'rows');
p_soft1=p_soft(ib,:);
%contains only highest peaks of all the unique coordinates
[~,ia,ib]=intersect(p_soft1(:,8:9),R(:,4:5),'rows');
p_soft2=horzcat(p_soft1(ia,:),R(ib,:));
%soft contains hopping value, time and coordinates at which hopping
%happened (first four columns), dedrifted coordinates for deltat prior hopping, coordinates
%prior hopping deltat(R)(last four columns)
% req_coord_soft1=soft(:,10:14);
%just attach radial density coordinates now
% clear H1 R
% load('E:\Devitrification\Sample5\Sample5_analysis\Sample5_radial_density_set1_part1.mat');
% [~,ia,ib]
AA=intersect(p_soft2(:,10:13),radial_density(:,[2 3 1 4]),'rows');
% req_coord_soft1=horzcat(p_soft2(ia,[1 2 3 4 5 6 7 8 10 11 12]),radial_density(ib,4:end));
req_coord_soft1=radial_density(ib,2:end);
req_coord_soft1(:,end+1)=1;
I=randi(length(req_coord_soft1(:,1)),600,1);
req_coord_soft=req_coord_soft1(I,:);