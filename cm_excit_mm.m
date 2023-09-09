%PART-I to identify crrs of particular range in soft particles
clearvars -except mostmobile K7
f=K7(:,12)>=141 & K7(:,13)>=141;
K7=K7(f,:);
a=10; b=15;
sigmas=21.7;
sigma=1.15*1.4*sigmas;
most_mob=[]; % soft contains crrs of particular range in soft particles for all frames
dm_excit=[];
ex=unique(K7(:,9));
f=(ex<=max(mostmobile(:,4)));
ex=ex(f,:);
% min(soft_particles_all(:,4))
for i=1:1:length(ex)
    f=(mostmobile(:,4)==ex(i));
    mm_particles=mostmobile(f,:);
    L=linkage(mm_particles(:,2:3)); % Links the particles
    C=cluster(L,'cutoff',sigma,'criterion','distance'); 
    mm_particles=horzcat(mm_particles,C);
    num=max(C);
    x=1:1:num;
    A=histc(C,x);    
    f=(A(:,1)>=a & A(:,1)<=b);
    if any(f) 
        B=nonzeros(f.*x'); %cluster numbers in which the size in the required range
        D=ismember(C,B);
        mm_particles=mm_particles(D,:); % contains coordinates of most mobile particles in cluster size of required range
        most_mob=vertcat(most_mob,mm_particles); % most_mob has 6 columns

        %PART-II To identify core like partilces
        %STEP-I By no of nearest neighbors 
        dist=pdist2(mm_particles(:,2:3),mm_particles(:,2:3),'euclidean','Smallest',10); %next few lines is for pnn
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        mm_particles=horzcat(mm_particles,count'); % 7th column added
        f=mm_particles(:,7)>2;
        mm_particles(:,7)=f;
        mm_particles1=mm_particles(f,:); % initial core particles
        mm_particles2=mm_particles(~f,:); % initial shell particles
        %STEP-II By no of nearest neighbors which are core like to iniitally identified shell like particles
        dist=pdist2(mm_particles1(:,2:3),mm_particles2(:,2:3),'euclidean','Smallest',10);
        f=(dist>0 & dist<=sigma);
        count=sum(f);
        f=count>=2;
        mm_particles2=mm_particles2(f,:); % additional core like particles
        [~,~,ib]=intersect(mm_particles2,mm_particles,'rows');
        mm_particles(ib,7)=1;
        f=mm_particles(:,7)==1;
        mm_particles=mm_particles(f,:);
        %core particles are labelled 1 and shell particles are now labelled 0

        % PART-III To calculate radius of gyration
        f=K7(:,9)==ex(i);
        excit=K7(f,:);
        if isempty(mm_particles)==0
            com=[];
            com(:,1)=accumarray(mm_particles(:,6),mm_particles(:,2),[],@mean);
            com(:,2)=accumarray(mm_particles(:,6),mm_particles(:,3),[],@mean);
            com(~any(com,2),:)=[];
            dist=pdist2(com(:,1:2),excit(:,12:13),'euclidean','Smallest',1);
            excit=horzcat(excit(:,[12 13 9]),dist');
            dm_excit=vertcat(dm_excit,excit);
        end
    else
        continue
    end
end
dm_excit(:,5)=dm_excit(:,4)/sigma;
distance=(0:0.5:10)';
pdm=histc(dm_excit(:,5),distance);