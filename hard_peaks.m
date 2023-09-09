clearvars -except soft_particles_all hard_particles_all K7
f=K7(:,12)>=141 & K7(:,13)>=141;
K7=K7(f,:);
boxsiz=4;
sigmas=21.7;
x=1500;
y=900;
hard_cont=[];
excit_cont=[];
b=30;
for i=1:1:max(hard_particles_all(:,4))
    f=hard_particles_all(:,4)>=i & hard_particles_all(:,4)<i+b;
    A=hist3(hard_particles_all(f,[6 7]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    A=reshape(A,[],1);
    hard_cont=horzcat(hard_cont,A);
    f=K7(:,9)>=i & K7(:,9)<i+b;
    B=hist3(K7(f,[12 13]),'Edges',{(0:((boxsiz)*sigmas):x) (0:((boxsiz)*sigmas):y)});
    B=reshape(B,[],1);
    excit_cont=horzcat(excit_cont,B);
end
C=hard_cont>30;
D=excit_cont>=5;
A=sum(C,2);
B=sum(D,2);
a=58;
CC(:,1)=1:1:max(hard_particles_all(:,4));
CC(:,2)=(C(a,:))';
CC(:,3)=(D(a,:))';
CC=double(CC);

% scatter(hard_particles_all(:,6),hard_particles_all(:,7),5,'filled');
% axis equal
% hold on
% scatter(soft_particles_all(:,6),soft_particles_all(:,7),'r','filled');
% axis([0 1500 0 900])
% sigmas=21.7;
% g_y=[0:4*sigmas:900]; % user defined grid Y [start:spaces:end]
% g_x=[0:4*sigmas:1500]; % user defined grid X [start:spaces:end]
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
% for i=1:length(g_y)
%    plot([g_x(1) g_x(end)],[g_y(i) g_y(i)],'k:') %x grid lines
%    hold on    
% end
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:','LineWidth',1.5) %y grid lines
%    hold on    
% end
% for i=1:length(g_y)
%    plot([g_x(1) g_x(end)],[g_y(i) g_y(i)],'k:','LineWidth',1.5) %x grid lines
%    hold on    
% end
%  for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:','LineWidth',1.5) %y grid lines
%    hold on    
% end
% for i=1:length(g_y)
%    plot([g_x(1) g_x(end)],[g_y(i) g_y(i)],'k:','LineWidth',1.5) %x grid lines
%    hold on    
% end