K=unique(K7(:,9));
ex_soft=[];
ex_hard=[];
ex_rand=[];
sigmas=21.7;
s=(0:1*sigmas:10*sigmas)';
for i=1:1:length(K)
    f=soft_particles_all(:,4)==K(i);
    A=soft_particles_all(f,:);
    f=hard_particles_all(:,4)==K(i);
    B=hard_particles_all(f,:);
%     f=H(:,3)==K(i);
%     C=H(f,:);
%     C1=randperm(length(C(:,1)),length(A(:,1)));
%     C=C(C1,:);
    f=K7(:,9)==K(i);
    D=K7(f,:);
    E1=pdist2(A(:,6:7),D(:,12:13),'euclidean','Smallest',1);
    E2=pdist2(B(:,6:7),D(:,12:13),'euclidean','Smallest',1);
%     E3=pdist2(C(:,1:2),D(:,12:13),'euclidean','Smallest',1);
    ex_soft=vertcat(ex_soft,E1');
    ex_hard=vertcat(ex_hard,E2');
%     ex_rand=vertcat(ex_rand,E3');
end
G1=histc(ex_soft,s);
G2=histc(ex_hard,s);
% G3=histc(ex_rand,s);