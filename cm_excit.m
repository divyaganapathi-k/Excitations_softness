%PART-I to identify crrs of particular range in soft particles
clearvars -except soft_particles_all hard_particles_all K7
f=K7(:,12)>=141 & K7(:,13)>=141;
K7=K7(f,:);
a=10; b=15;
sigmas=21.7;
sigma=1.15*1.4*sigmas;
soft=[]; % soft contains crrs of particular range in soft particles for all frames
dm_excit=[];
ex=unique(K7(:,9));
% min(soft_particles_all(:,4))
for i=1:1:length(ex)
    f=(soft_particles_all(:,4)==ex(i));
    soft_particles=soft_particles_all(f,:);
    L=linkage(soft_particles(:,6:7)); % Links the particles
    C=cluster(L,'cutoff',sigma,'criterion','distance'); 
    soft_particles=horzcat(soft_particles,C);
    num=max(C);
    x=1:1:num;
    A=histc(C,x);    
    f=(A(:,1)>=a & A(:,1)<=b);
    if any(f) 
        B=nonzeros(f.*x'); %cluster numbers in which the size in the required range
        D=ismember(C,B);
        soft_particles=soft_particles(D,:); % contains coordinates of most mobile particles in cluster size of required range
        soft=vertcat(soft,soft_particles); % soft has 8 columns

        %PART-II To identify core like partilces
        %STEP-I By no of nearest neighbors 
        dist=pdist2(soft_particles(:,6:7),soft_particles(:,6:7),'euclidean','Smallest',10); %next few lines is for pnn
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        soft_particles=horzcat(soft_particles,count'); % 9th column added
        f=soft_particles(:,9)>2;
        soft_particles(:,9)=f;
        soft_particles1=soft_particles(f,:); % initial core particles
        soft_particles2=soft_particles(~f,:); % initial shell particles
        %STEP-II By no of nearest neighbors which are core like to iniitally identified shell like particles
        dist=pdist2(soft_particles1(:,6:7),soft_particles2(:,6:7),'euclidean','Smallest',10);
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        f=count>=2;
        soft_particles2=soft_particles2(f,:); % additional core like particles
        [~,~,ib]=intersect(soft_particles2,soft_particles,'rows');
        soft_particles(ib,9)=1;
        f=soft_particles(:,9)==1;
        soft_particles=soft_particles(f,:);
        %core particles are labelled 1 and shell particles are now labelled 0

        % PART-III To calculate radius of gyration
        f=K7(:,9)==ex(i);
        excit=K7(f,:);
        com=[];
        com(:,1)=accumarray(soft_particles(:,8),soft_particles(:,6),[],@mean);
        com(:,2)=accumarray(soft_particles(:,8),soft_particles(:,7),[],@mean);
        com(~any(com,2),:)=[];
        dist=pdist2(com(:,1:2),excit(:,12:13),'euclidean','Smallest',1);
        excit=horzcat(excit(:,[12 13 9]),dist');
        dm_excit=vertcat(dm_excit,excit);
    else
        continue
    end
end
dm_excit(:,5)=dm_excit(:,4)/sigma;
distance=(0:0.5:10)';
pdm=histc(dm_excit(:,5),distance);