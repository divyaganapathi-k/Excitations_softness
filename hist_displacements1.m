% clearvars -except phop_all H
% A=unique(phop_all(:,5));
% a=0;
% dia=38;
% times=[];
% for i=1:1:length(A)
%     f=phop_all(:,5)==A(i);
%     phop=phop_all(f,:);
%     hop=smooth(phop(:,1),50);
%     pks=[]; pks1=[];
%     [pks(:,1),pks(:,2)]=findpeaks(hop,'minpeakheight',0.02);
%     if isempty(pks)==0
%         hop1=0.15-hop; 
%         [pks1(:,1),pks1(:,2)]=findpeaks(hop1,'minpeakheight',0.01);
%         dist1=pdist2(pks(:,2),pks(:,2),'euclidean','Smallest',2); 
%         dist2=pdist2(pks1(:,2),pks(:,2),'euclidean','Smallest',1);
%         if isempty(pks1)==0
%             if length(pks(:,1))~=1
%                 dist1=dist1(2,:);
%                 dist1=dist1';
%                 dist2=dist2';
%                 dist2=horzcat(dist2,pks(:,2));
%                 B=dist1>dist2(:,1);
%                 dist2(:,1)=dist2(:,1).*B;
%                 f=dist2(:,1)~=0;
%                 dist2=dist2(f,:);
%                  if isempty(dist2)==0
%                     ts=[];
%                     ts(:,1)=dist2(:,2)-dist2(:,1);
%                     ts(:,2)=dist2(:,2)+dist2(:,1);
%                     ts(:,3)=dist2(:,2);
%                     ts(:,4)=dist2(:,1);
%                     ts(:,5)=A(i);
%                     times=vertcat(times,ts);
%                 end
%             else
%                 ts=[];
%                 ts(:,1)=pks(:,2)-dist2;
%                 ts(:,2)=pks(:,2)+dist2;
%                 ts(:,3)=pks(:,2);
%                 ts(:,4)=dist2;
%                 ts(:,5)=A(i);
%                 times=vertcat(times,ts);
%             end
%         else
%             continue
%         end
%     end
% end
% [~,ia,ib]=intersect(H(:,3:4),times(:,[1, 5]),'rows');
% I=[H(ia,:),times(ib,3)];
% [~,ia,ib]=intersect(H(:,3:4),times(:,[2, 5]),'rows');
% J=[H(ia,:),times(ib,3)];
% [~,ia,ib]=intersect(I(:,[5,4]),J(:,[5,4]),'rows');
% K=[I(ia,:),J(ib,1:3)];
% K(:,8)=((K(:,1)-K(:,6)).^2+(K(:,1)-K(:,6)).^2).^(0.5);
% K(:,9)=K(:,8)/dia;
% y1=(0:1000:12000)';
% y2=(0:0.05:1.2)';
% Pdeltat=histc((abs(times(:,4)))*20,y1);
% Pdeltar=histc(K(:,9),y2);

C1=accumarray(H(:,4),H(:,3),[],@max);
f=find(C1);
D1=horzcat(C1(f),f);
C2=accumarray(H(:,4),H(:,3),[],@min);
f=find(C2);
D2=horzcat(C2(f),f);
Lia=ismember(H(:,3:4),D2,'rows');
B1=H(Lia,:);
Lia=ismember(H(:,3:4),D1,'rows');
B2=H(Lia,:);
B=[];
B=B2(:,1:2)-B1(:,1:2);
B(:,3)=(B(:,1).^2+B(:,2).^2).^(0.5);
B(:,3)=B(:,3)/38;
C=histc(B(:,3),0:0.04:1);
x=(0:0.04:1)';
D=abs(B2(:,3)-B1(:,3));