clearvars -except mostmobile
clust_size_count=zeros(50,1);
sigmas=21.7;
sigma=1.15*1.4*sigmas;
for i=min(mostmobile(:,4)):1:max(mostmobile(:,4))
    f=(mostmobile(:,4)==i);
    mm_particles=mostmobile(f,:);
    L=linkage(mm_particles(:,2:3)); % Links the particles
    C=cluster(L,'cutoff',sigma,'criterion','distance'); 
    mm_particles=horzcat(mm_particles,C);
    num=max(C);
    x=1:1:num;
    A=[];
    A=histc(C,x);
    B=histc(A,1:1:50);
%     A(numel(clust_size_count))=0;
    clust_size_count=clust_size_count+B;
end