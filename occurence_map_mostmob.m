sigmas=21.7;
boxsiz=1;
x=1500;
y=900;
%  C=hist3(mostmobile(:,[2 3]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
 C=hist3(crr(:,[2 3]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
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
% colormap(ax1,flipud(cmap))
caxis(ax1,[0 4]);
%to add excitations
hold on
% ax2=axes;
% f2=K7(:,9)>a+100 & K7(:,9)<=b+100;
%  f2=K7(:,9)<=12000;
%  scatter(ax2,K7(f2,12)/sigmas,K7(f2,13)/sigmas,6,'w','filled');
% scatter(ax2,K7(:,12)/sigmas,K7(:,13)/sigmas,10,K7(:,9),'filled');
% axis equal
%  axis([0 70 0 40])
%  ax2.Visible = 'off';
% ax2.XTick = [];
% ax2.YTick = [];
% colormap(ax2,autumn)
% flipud(gray)
% caxis(ax2,[a+100 b+100]);
% linkaxes([ax1,ax2])
%  colorbar(ax1,'Location','west');
% colorbar(ax2,'Location','east');

print('H:\DF_ML\W5_crr.tif','-dtiff','-r300');