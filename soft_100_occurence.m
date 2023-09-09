clearvars -except soft_particles_all K7
sigmas=21.7;
boxsiz=1;
x=1500;
y=900;
load('colormap_soft.mat')
for i=1:100:max(soft_particles_all(:,4))
    f1=soft_particles_all(:,4)>i & soft_particles_all(:,4)<=i+100;
    C=hist3(soft_particles_all(f1,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    D=log(C);
    D(isinf(D))=0;
    figure
    ax1=axes;
    contourf(ax1,D,'Fill','on','edgecolor','none');
    set(gcf,'WindowStyle','docked');
    set(gca,'XDir','reverse');
    set(gca,'TickDir','out');
    axis equal
    axis([0 40 0 70])
    camroll(-90)
    colormap(ax1,cmap)
    print(strcat('H:\DF_ML\Images\soft_100\W2\',num2str(i)),'-dtiff','-r300');
    close all
end