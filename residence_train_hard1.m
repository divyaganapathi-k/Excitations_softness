% load('E:\Devitrification\Sample5\Sample5_analysis\Sample5_phop_all_t_36.mat');
%to find hard particles in the system with calculation of residence time
% clearvars -except phop_all
% histogram of phop
% edges=0.002:0.002:4.44;
% A=histc(phop_all(:,1),edges);
%calculation of phop threshold(pth) was calculated by power law fitting of the
%above histogram in origin
pth=0.135;
% calculation of  residence time probabilities
phop_all=sortrows(phop_all,[5 4]);
[pks(:,1),pks(:,2)]=findpeaks(phop_all(:,1));
f=pks(:,1)>pth;
phop_required=phop_all(pks(f,2),:);
% phop_required=phop_all(pks(:,2),:);
% f=phop_required(:,1)>=pth;
% phop_required=phop_required(f,:);
phop_required1=circshift(phop_required,1);
diff=phop_required-phop_required1;
% f=(diff(:,5)==0);
% edges1=1:1:1000;
% residence_time=histc(diff(f,4),edges1);

%selecting hard and soft particles
% %soft particles
% f=(phop_all(:,1)>0.1);
% phop_soft=phop_all(f,:);
% phop_soft=sortrows(phop_soft,-1);
% phop_soft=phop_soft(1:1000,:); %particles to be used for soft training
% phop_soft(:,6)=1;
 
%hard particles
phop_required=horzcat(phop_required,diff(:,4:5));
f=(phop_required(:,7)==0 & phop_required(:,4)>0 & phop_required(:,4)<=2000);
phop_required=phop_required(f,:);
phop_required=sortrows(phop_required,-6);
phop_hard=phop_required(1:600,:);
phop_hard=phop_hard(:,1:5);
% phop_hard(:,6)=-1;
%phop_hard contains dedrifted coordinates
% clear phop_all
% load('E:\Devitrification\Sample5\Sample5_analysis\Sample5_track(28).mat');
[~,ia,ib]=intersect(phop_hard(:,2:5),H,'rows');
req_coord_hard=horzcat(R(ib,1:2),phop_hard(ia,4:5));
% clear H1 R
% load('E:\Devitrification\Sample5\Sample5_analysis\Sample5_radial_density_set1_part1.mat');
[~,ia,ib]=intersect(req_coord_hard(:,1:3),radial_density(:,1:3),'rows');
req_coord_hard=horzcat(req_coord_hard(ia,:),radial_density(ib,4:end));
req_coord_hard(:,end+1)=-1;
% 


% [C,ia,ib]=intersect(phop_soft(:,2:5),phop_hard(:,2:5),'rows');
% phop_hard(ib,:)=[];
% phop_hard=phop_hard(1:1000,:);
% 
% train_input=vertcat(phop_soft,phop_hard);
% %%%%%%%%%%%%%%%%
%not required
% phop_all=sortrows(phop_all,[5 4]);
% pks_all=[];
% max(phop_all(:,5))   
% for i=1:1:5
%     f=(phop_all(:,5)==i);
%     if (sum(f)>=3)
%         [pks,locs]=findpeaks(phop_all(f,1));
%         pk=horzcat(pks,locs);
%         pks_all=vertcat(pks_all,pk);
%     end
% end
% f=pks_all(:,1)>=pth;
% phop_peaks=phop_all(pks_all(f,2),:);
% f=(phop_all(:,1)>=pth);
% phop_required=phop_all(f,:);
% phop_required=sortrows(phop_required,[5 4]);
% phop_required1=circshift(phop_required,1);
% phop_required2=phop_required-phop_required1;
% f=(phop_required2(:,5)==0);
% hist(phop_required2(f,4),1000);
% edges=1:1:1000;
% BB=histc(phop_required2(:,4),edges);
%%%%%%%%%%%%%%%%%%%%%%%%
