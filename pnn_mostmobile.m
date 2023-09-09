clearvars -except mostmobile
% f=K7(:,12)>=141 & K7(:,13)>=141;
% K7=K7(f,:);
a=4; b=30;
for j=1:1:1
    sigmas=21.7;
    sigma=1.15*1.4*sigmas;
    y=1:1:10;
    clust_count=zeros(100,1);
    nn_count_crr=zeros(10,1);
    number_crr=0;
    crr=[];
    for i=min(mostmobile(:,4)):1:max(mostmobile(:,4))
        f=(mostmobile(:,4)==i);
        mm_particles=mostmobile(f,:);
        L=linkage(mm_particles(:,2:3)); % Links the particles
        C=cluster(L,'cutoff',sigma,'criterion','distance'); 
        mm_particles=horzcat(mm_particles,C);
        num=max(C);
        x=1:1:num;
        A=histc(C,x);
        f=(A(:,1)>=a & A<=b);
        B=nonzeros(f.*x'); %cluster numbers in which the size in the required range
        D=ismember(C,B);
        number_crr=number_crr+length(B);
        mm_particles=mm_particles(D,:); % contains coordinates of most mobile particles in cluster size of required range
        dist=pdist2(mm_particles(:,2:3),mm_particles(:,2:3),'euclidean','Smallest',10); %next few lines is for pnn
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        G=histc(count,y); G=G';
        nn_count_crr=nn_count_crr+G;
        crr=vertcat(crr,mm_particles);
    end
    total=sum(nn_count_crr);
    nn_count_crr=nn_count_crr/total;
end