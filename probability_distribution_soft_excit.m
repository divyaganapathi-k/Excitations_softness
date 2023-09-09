clearvars -except soft_particles_all hard_particles_all K7
f=K7(:,12)>=141 & K7(:,13)>=141;
K7=K7(f,:);
boxsiz=4;
sigmas=21.7;
x=1500;
y=900;
soft_cont=[];
excit_cont=[];
b=10;
for i=1:1:max(soft_particles_all(:,4))
    f=soft_particles_all(:,4)>=i & soft_particles_all(:,4)<i+b;
    A=hist3(soft_particles_all(f,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    A=reshape(A,[],1);
    soft_cont=horzcat(soft_cont,A);
    f=K7(:,9)>=i & K7(:,9)<i+b;
    B=hist3(K7(f,[12 13]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    B=reshape(B,[],1);
    excit_cont=horzcat(excit_cont,B);
end
soft_count=reshape(soft_cont,[],1);
excit_count=reshape(excit_cont,[],1);
x1=(10:10:100)';
y1=(1:1:50)';
C=histc(soft_count,x1);
D=histc(excit_count,y1);