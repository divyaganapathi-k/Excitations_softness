clearvars -except soft_particles_all
clust_size_count=zeros(50,1);
sigmas=21.7;
sigma=1.15*1.4*sigmas;
for i=min(soft_particles_all(:,4)):1:max(soft_particles_all(:,4))
    f=(soft_particles_all(:,4)==i);
    soft_particles=soft_particles_all(f,:);
    L=linkage(soft_particles(:,1:2)); % Links the particles
    C=cluster(L,'cutoff',sigma,'criterion','distance'); 
    soft_particles=horzcat(soft_particles,C);
    num=max(C);
    x=1:1:num;
    A=[];
    A=histc(C,x);
    B=histc(A,1:1:50);
%     A(numel(clust_size_count))=0;
    clust_size_count=clust_size_count+B;
end