sigmas=21.7;
boxsiz=1;
x=1500;
y=900;
K7(:,14)=1;
% hard_particles_all(:,6:7)=hard_particles_all(:,6:7)./sigmas;
% hard_particles_all(:,6:7)=ceil(hard_particles_all(:,6:7));
% soft_particles_all(:,6:7)=soft_particles_all(:,6:7)./sigmas;
% soft_particles_all(:,6:7)=ceil(soft_particles_all(:,6:7));
% A=hist3(hard_particles_all(:,6:7),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
% % B=A;
% B=log10(A);
% B(isinf(B))=0;
% figure
% contourf(B,'Fill','on','edgecolor','none');
% set(gcf,'WindowStyle','docked');
% set(gca,'XDir','reverse');
% camroll(-90)
% set(gca,'TickDir','out');
% axis equal
% load('colormap_hard.mat')
% colormap(cmap)
% caxis([0 4]);
% S=0.2*ones(length(K7(:,1)),1);
% C=ones(length(K7(:,1)),3);
% hold on
% % scatter(K7(:,13)/sigmas,K7(:,12)/sigmas,15,'r');
% scatter3sph(K7(:,13)/sigmas,K7(:,12)/sigmas,K7(:,14),'color',C,'size',S,'transp',1);
% hold off
% print('H:\DF_ML\Images\occurence_maps\W2_hard_excit.tif','-dtiff','-r1000');
% contourcmap('jet',[0:5:50],'colorbar','on','location','horizontal');
 f=soft_particles_all(:,4)<=12000;
C=hist3(hard_particles_all(:,6:7),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
% D=C;
D=log10(C);
D(isinf(D))=0;
figure
contourf(D,'Fill','on','edgecolor','none');
% ,'edgecolor','none'
% set(c,'LineColor','none')
set(gcf,'WindowStyle','docked');
set(gca,'XDir','reverse');
camroll(-90)
set(gca,'TickDir','out');
axis equal
load('cmap_hard_soft.mat')
colormap(cmap)
colormap(flipud(cmap))
caxis([0 4]);
% S=0.2*ones(length(K7(:,1)),1);
% C=ones(length(K7(:,1)),3);
% f=K7(:,4)<=1600;
% hold on
% scatter3sph(K7(f,13)/sigmas,K7(f,12)/sigmas,K7(f,14),'color',C,'size',S,'transp',1);
% hold off
 print('H:\DF_ML\Images\occurence_maps\W2_hard_W4.tif','-dtiff','-r1000');