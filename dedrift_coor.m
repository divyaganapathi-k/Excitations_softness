clearvars -except H R pos_lst hard_particles_all soft_particles_all
A=R(:,[1 2 4 5])-H;
A(:,3)=R(:,4);
B(:,1)=accumarray(A(:,3),A(:,1),[],@mean);
B(:,2)=accumarray(A(:,3),A(:,2),[],@mean);
pos_lst1(:,1)=pos_lst(:,1)-B(pos_lst(:,4),1);
pos_lst1(:,2)=pos_lst(:,2)-B(pos_lst(:,4),2);
pos_lst1=horzcat(pos_lst1,pos_lst);
[~,ia,ib]=intersect(hard_particles_all(:,[2 3 1 4]),pos_lst1(:,3:6),'rows');
hard_particles_all=horzcat(hard_particles_all(ia,:),pos_lst1(ib,1:2));
[~,ia,ib]=intersect(soft_particles_all(:,[2 3 1 4]),pos_lst1(:,3:6),'rows');
soft_particles_all=horzcat(soft_particles_all(ia,:),pos_lst1(ib,1:2));
