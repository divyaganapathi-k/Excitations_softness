clearvars -except phop_all H R radial_density
deltat=32;
pth=0.135;
[pks(:,1),pks(:,2)]=findpeaks(phop_all(:,1));
f=pks(:,1)>pth;
phop_required=phop_all(pks(f,2),:);
phop_required1=circshift(phop_required,1);
diff=phop_required-phop_required1; 
phop_required=horzcat(phop_required,diff(:,4:5));
f=(phop_required(:,7)==0 & phop_required(:,4)>0);
phop_required=phop_required(f,:);
phop_required=sortrows(phop_required,-6);
phop_hard=phop_required(1:600,:);
phop_hard=phop_hard(:,1:5);
[~,ia,ib]=intersect(phop_hard(:,2:5),H,'rows');
req_coord_hard=horzcat(R(ib,1:2),phop_hard(ia,4:5));
[~,ia,ib]=intersect(req_coord_hard(:,1:3),radial_density(:,1:3),'rows');
req_coord_hard=horzcat(req_coord_hard(ia,:),radial_density(ib,4:end));
req_coord_hard(:,end+1)=-1;