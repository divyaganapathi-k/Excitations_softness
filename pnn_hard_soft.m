clearvars -except soft_particles_all hard_particles_all
a=5;
for j=1:1:1
    sigmas=21.7;
    sigma=1.15*1.4*sigmas;
    y=1:1:10;
    clust_count=zeros(100,1);
    nn_count_soft=zeros(10,1);
    number_soft=0;
    soft=[];
    for i=min(soft_particles_all(:,4)):1:max(soft_particles_all(:,4))
        f=(soft_particles_all(:,4)==i);
        soft_particles=soft_particles_all(f,:);
        L=linkage(soft_particles(:,2:3)); % Links the particles
        C=cluster(L,'cutoff',sigma,'criterion','distance'); 
        soft_particles=horzcat(soft_particles,C);
        num=max(C);
        x=1:1:num;
        A=histc(C,x);
        f=(A(:,1)>a);
        B=nonzeros(f.*x'); %cluster numbers in which the size in the required range
        D=ismember(C,B);
        number_soft=number_soft+length(B);
%         E=D.*soft_particles(:,6);
%         [F,ia,~]=intersect(soft_particles(:,6),E);
        soft_particles=soft_particles(D,:); % contains coordinates of most mobile particles in cluster size of required range
%         soft_particles=soft_particles(ia,:); % contains coordinates of most mobile particles in cluster size of required range
        dist=pdist2(soft_particles(:,2:3),soft_particles(:,2:3),'euclidean','Smallest',10); %next few lines is for pnn
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        G=histc(count,y); G=G';
        nn_count_soft=nn_count_soft+G;
        soft=vertcat(soft,soft_particles);
    end
    total=sum(nn_count_soft);
    nn_count_soft=nn_count_soft/total;
    % 
    clust_count=zeros(100,1);
    nn_count_hard=zeros(10,1);
    number_hard=0;
    hard=[];
    for i=min(hard_particles_all(:,4)):1:max(hard_particles_all(:,4))
        f=(hard_particles_all(:,4)==i);
        hard_particles=hard_particles_all(f,:);
        L=linkage(hard_particles(:,2:3)); % Links the particles
        C=cluster(L,'cutoff',sigma,'criterion','distance'); 
        hard_particles=horzcat(hard_particles,C);
        num=max(C);
        x=1:1:num;
        A=histc(C,x);
    %     & A(:,1)<13
        f=(A(:,1)>a);
        B=nonzeros(f.*x'); %cluster numbers in which the size in the required range
        D=ismember(C,B);
        number_hard=number_hard+length(B);
        hard_particles=hard_particles(D,:);
%         E=D.*hard_particles(:,6);
%         [F,ia,~]=intersect(hard_particles(:,6),E);
%         hard_particles=hard_particles(ia,:); % contains coordinates of most mobile particles in cluster size of required range
    %     hard_particles(:,4)=i;
        dist=pdist2(hard_particles(:,2:3),hard_particles(:,2:3),'euclidean','Smallest',10); 
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        G=histc(count,y); G=G';
        nn_count_hard=nn_count_hard+G;
        hard=vertcat(hard,hard_particles);
    end
    total=sum(nn_count_hard);
    nn_count_hard=nn_count_hard/total;
%     save(strcat('F:\3D_slices_new\hard_soft_cluster_1_',num2str(j)),'hard','soft');
end
%  [~,ia,ib]=intersect(dedrift_coordinates(:,[4 5 3]),soft(:,1:3),'rows');
% soft=horzcat(soft(ib,:),dedrift_coordinates(ia,1:2));
% [~,ia,ib]=intersect(dedrift_coordinates(:,[4 5 3]),hard(:,1:3),'rows');
% hard=horzcat(hard(ib,:),dedrift_coordinates(ia,1:2));
% % f=psi6_count(:,3)<25 & psi6_count(:,4)>0.9 & psi6_count(:,7)>3 & psi6_count(:,5)>3;
% % psi6=psi6_count(f,:);
% figure
% scatter(hard(:,6),hard(:,7),'r','filled');
% axis equal
% hold on
% scatter(soft(:,6),soft(:,7),'b','filled');
% scatter(psi6(:,8),psi6(:,9),'g','filled');
% axis([110 900 110 900])