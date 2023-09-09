A=unique(K7(:,4));
for i=1:1:length(A)
    f=hard_particles_all(:,4)==A(i);
    scatter(hard_particles_all(f,6),hard_particles_all(f,7),20,'filled');
    hold on
    f=soft_particles_all(:,4)==A(i);
    scatter(soft_particles_all(f,6),soft_particles_all(f,7),20,'r','filled');
    f=K7(:,4)==A(i);
    scatter(K7(f,12),K7(f,13),20,'k','LineWidth',1.5);
    axis equal
    axis([150 1400 150 850])
    set(gca,'TickDir','out');
    hold off
    print(strcat('H:\DF_ML\Images\hard_soft_excit\W4\W4_',num2str(A(i))),'-dtiff','-r300');
end