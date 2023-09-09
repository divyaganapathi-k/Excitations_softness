clearvars -except HH R H soft_particles_all hard_particles_all hard soft req_coor
K2=[];
a=1:100:max(HH(:,3));
for i=1:1:(length(a)-1)
    f=HH(:,3)>=a(i) & HH(:,3)<a(i+1);
    HH1=HH(f,:);
    f=find(HH1(:,5:end));
    [I(:,1),I(:,2)]=ind2sub(size(HH1(:,5:end)),f);
    I=sortrows(I,1);
    [J,ia,~]=unique(I(:,1));
    J(:,2)=I(ia,2);
    J(:,3:6)=HH1(J(:,1),1:4);
    J=sortrows(J,[6 2]);
    [~,ia,~]=unique(J(:,6));
%     K=accumarray(J(:,6),J(:,2),[],@min);
%     K1=nonzeros(K);
%     K1(:,2)=unique(J(:,3));
    K=J(ia,2:end);
    K2=vertcat(K2,K);
    I=[]; J=[]; K=[]; K1=[];
end
K2=sortrows(K2,5);
K3=accumarray(K2(:,5),K2(:,1),[],@min);
K4=K2(:,1)-(1.5)*K3(K2(:,5));
f=(K4<0);
K5=K2(f,:);
t=2:2:100;
excit_hist=histc(K5(:,1),t);
%to find original coordinates to link to the soft and hard particles 
[~,ia,ib]=intersect(HH(:,1:4),K5(:,2:5),'rows');
K6=horzcat(K5(ib,:),R(ia,:));
% figure
% scatter(hard_particles_all(:,2),hard_particles_all(:,3),5,'filled');
% hold on
% scatter(soft_particles_all(:,2),soft_particles_all(:,3),5,'r','filled');
% axis equal
% axis([150 1400 150 850])
% scatter(K6(:,6),K6(:,7),10,'k','filled');
% print('C:\Users\Divya\Desktop\W4_83.8_hard_soft_excit.tif','-dtiff','-r300');
% scatter(hard(:,2),hard(:,3),5,'filled');
% hold on
% scatter(soft(:,2),soft(:,3),5,'filled');
% axis equal
% axis([150 1400 150 850])
% scatter(K6(:,6),K6(:,7),'k','filled');
% scatter(hard(:,2),hard(:,3),5,'filled');

% average softness values of excitations
f=req_coor(:,2)>141 & req_coor(:,3)>141 & req_coor(:,2)<1409 & req_coor(:,3)<809;
req_coor=req_coor(f,:);
[~,ia,ib]=intersect(req_coor(:,1:4),K6(:,[8 6 7 9]),'rows');
K7=horzcat(K6(ib,:),req_coor(ia,5));
y=(-5:0.5:5)';
A=histc(K7(:,11),y);
B=histc(req_coor(:,5),y);
C=histc(soft_particles_all(:,5),y);
[~,ia,ib]=intersect(R,K7(:,6:10),'rows');
K7=horzcat(K7(ib,:),H(ia,1:2));
%contents of K7 matrix
%Column 1 - deltat, Column 2-5 - smoothened dedrifted coordinates,time and id, Column 6-10 from
%R(original coordinates to link to soft and hard particle coordinates), Column 11-
%soft value, Column 12-13 - dedrifted coordinates