sigmas=21.7;
boxsiz=1;
x=1500;
y=900;
% hard_particles_all(:,6:7)=hard_particles_all(:,6:7)./sigmas;
% hard_particles_all(:,6:7)=ceil(hard_particles_all(:,6:7));
% soft_particles_all(:,6:7)=soft_particles_all(:,6:7)./sigmas;
% soft_particles_all(:,6:7)=ceil(soft_particles_all(:,6:7));
% A=hist3(hard_particles_all(:,6:7),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
% B=A;
% B=log(A);
% B(isinf(B))=0;
% figure
% contourf(B);
% set(gcf,'WindowStyle','docked');
% set(gca,'XDir','reverse');
% camroll(-90)
% set(gca,'TickDir','out');
% axis equal
% load('colormap_hard.mat')
% colormap(cmap)
% caxis([0 9]);
% print('H:\DF_ML\Images\occurence_maps\W8_hard_83.8.tif','-dtiff','-r300');
% contourcmap('jet',[0:5:50],'colorbar','on','location','horizontal');
% max(soft_particles_all(:,4));
% a=7000; b=7050;
% f1=soft_particles_all(:,4)>a & soft_particles_all(:,4)<=b;
% max(soft_particles_all(:,4))
%  f1=soft_particles_all(:,4)<=12000;
% max(hard_particles_all(:,4))
 f1=hard_particles_all(:,4)<=max(hard_particles_all(:,4));
%  C=hist3(soft_particles_all(f1,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
 C=hist3(hard_particles_all(f1,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
% D=C;
D=log10(C);
D(isinf(D))=0;
figure
ax1=axes;
contourf(ax1,D,'Fill','on','edgecolor','none');
% set(c,'LineColor','none')
set(gcf,'WindowStyle','docked');
set(gca,'XDir','reverse');
set(gca,'TickDir','out');
axis equal
axis([0 40 0 70])
camroll(-90)
load('cmap_hard_soft.mat')
colormap(ax1,cmap)
% colorbar
colormap(ax1,flipud(cmap))
caxis(ax1,[0 4]);
%to add excitations
hold on
 ax2=axes;
% f2=K7(:,9)>a+100 & K7(:,9)<=b+100;
 f2=K7(:,9)<=12000;
 scatter(ax2,K7(f2,12)/sigmas,K7(f2,13)/sigmas,6,'w','filled');
% scatter(ax2,K7(:,12)/sigmas,K7(:,13)/sigmas,10,K7(:,9),'filled');
axis equal
axis([0 70 0 40])
 ax2.Visible = 'off';
% ax2.XTick = [];
% ax2.YTick = [];
% colormap(ax2,autumn)
% flipud(gray)
 caxis(ax2,[a+100 b+100]);
linkaxes([ax1,ax2])
%  colorbar(ax1,'Location','west');
% colorbar(ax2,'Location','east');

print('H:\DF_ML\W5_hard_new_W41.tif','-dtiff','-r300');