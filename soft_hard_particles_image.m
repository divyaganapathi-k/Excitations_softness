 scatter(hard_particles_all(:,6),hard_particles_all(:,7),5,'filled');
 hold on
 scatter(soft_particles_all(:,6),soft_particles_all(:,7),5,'r','filled');
 set(gcf,'WindowStyle','docked');
 axis equal
 axis([150 1400 150 850])
 set(gca,'TickDir','out');
 hold off
 print('H:\DF_ML\Images\hard_soft_particles_dedrifted\75.75\W8_75.75.tif','-dtiff','-r300');
