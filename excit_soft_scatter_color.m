% a=max(soft_particles_all(:,4))/1000;
% a=ceil(a);
% for i=1:1:a
%     f=soft_particles_all(:,4)>=(i-1)*1000 & soft_particles_all(:,4)<=i*1000;
%     soft=soft_particles_all
% end

% soft_particles_all(:,4)=ceil(soft_particles_all(:,4)/10);
% K7(:,9)=ceil(K7(:,9)/100);
figure
a=1;
b=100;
ax1=axes;
f1=soft_particles_all(:,4)>a & soft_particles_all(:,4)<=b;
scatter(ax1,soft_particles_all(:,6),soft_particles_all(:,7),10,soft_particles_all(:,4),'filled');
% scatter(ax1,soft_particles_all(f1,6),soft_particles_all(f1,7),10,soft_particles_all(f1,4),'filled',,'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1);
axis equal
axis([150 1400 150 850])
load('colormap_soft.mat')
colormap(ax1,cmap)
% colormap(ax1,'jet')
caxis(ax1,[a b])
set(ax1,'TickDir','out');
hold on
ax2=axes;
f2=K7(:,9)>a & K7(:,9)<=b;
scatter(ax2,K7(f2,12),K7(f2,13),20,K7(f2,9),'LineWidth',3);
scatter(ax2,K7(:,12),K7(:,13),20,K7(:,9),'LineWidth',2);
axis equal
axis([150 1400 150 850])
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
colormap(ax2,'parula')
caxis(ax2,[a b])
% colorbar(ax1,'Location','west');
% colorbar(ax2,'Location','east');
linkaxes([ax1,ax2])
% flipud(pink)