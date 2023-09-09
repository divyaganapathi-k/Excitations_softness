clearvars -except soft_particles_all hard_particles_all K7
f=K7(:,12)>=141 & K7(:,13)>=141;
K7=K7(f,:);
boxsiz=2;
sigmas=21.7;
x=1500;
y=900;
soft_cont=[];
excit_cont=[];
hard_cont=[];
b=300;
for i=1:1:max(soft_particles_all(:,4))
    f=soft_particles_all(:,4)>=i & soft_particles_all(:,4)<i+b;
    A=hist3(soft_particles_all(f,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    A=reshape(A,[],1);
    soft_cont=horzcat(soft_cont,A);
    f=K7(:,9)>=i & K7(:,9)<i+b;
    B=hist3(K7(f,[12 13]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    B=reshape(B,[],1);
    excit_cont=horzcat(excit_cont,B);
    f=hard_particles_all(:,4)>=i & hard_particles_all(:,4)<i+b;
    C=hist3(hard_particles_all(f,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    C=reshape(C,[],1);
    hard_cont=horzcat(hard_cont,C);
end
a=200;
D=soft_cont>a;
E=excit_cont>=5;
F=hard_cont>a;
A=sum(D,2);
B=sum(E,2);
C=sum(F,2);
a=83;
CC(:,1)=1:1:max(soft_particles_all(:,4));
CC(:,2)=(D(a,:))';
CC(:,3)=(E(a,:))';
CC(:,4)=(F(a,:))';
CC=double(CC);