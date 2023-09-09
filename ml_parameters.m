% PART-I histogram of phop values
% the whole experimental duration is considered, base was subtracted by
% taking the minium value in all the trajectories
% clearvars -except phop_all
% phop_all=sortrows(phop_all,[5,4]);
y=(0.0001:0.001:1.2)';
% phop=phop_all;
% % f=phop_all(:,4)<=6500;
% % phop=phop_all(f,:);
% % t_res_av=zeros(length(y),1);
A=accumarray(phop(:,5),phop(:,1),[],@min);
phop(:,6)=phop(:,1)-A(phop(:,5));
% h_phop=histc(phop(:,6),y);
% a=1;
% PART-II average residence time as a function of phop cut off (an ok
% solution)
% B=unique(phop(:,5));
% phop1=[];
% for i=1:1:length(B)
%     f=phop(:,5)==B(i);
%     C=phop(f,:);
%     C(:,6)=smooth(C(:,1),10);
%     phop1=vertcat(phop1,C);
% end
% phop1=phop;
% A=accumarray(phop1(:,5),phop1(:,6),[],@min);
% phop1(:,7)=phop1(:,6)-A(phop1(:,5));
% % phop=[];
% % phop=phop1;
% % phop1=[];
% A=accumarray(phop1(:,4),1);
% f=find(A>1000);
% B=ismember(phop1(:,4),f);
% phop1=phop1(B,:);
% [~,pks]=findpeaks(phop1(:,7));
% phop1=phop1(pks,[7 4 5]);
% for i=1:1:length(y)
%     f=phop1(:,1)>=y(i);
%     phop2=phop1(f,:);
%     phop3=circshift(phop2,1);
%     phop4=phop2-phop3;
%     f=phop4(:,3)==0;
%     t_res_av(i,1)=mean(phop4(f,2));
% end
% 
% % PART-III  distribution of delta(r) values for the choses pth
% %first kind may not be fully appropriate
% [~,pks]=findpeaks(phop(:,6));
% phop1=phop(pks,[6 4 5]);
% f=phop1(:,1)>=0.02;
% req=phop1(f,2:3);
% req1=[req(:,1)+150,req(:,2)];
% req2=[req(:,1)-150,req(:,2)];
% Lia=ismember(H(:,3:4),req1,'rows');
% HH=H(Lia,:);
% HH=sortrows(HH,[4,3]);
% Lia=ismember(H(:,3:4),req2,'rows');
% HH1=H(Lia,:);
% HH1=sortrows(HH1,[4,3]);
% HH2=HH-HH1;
% HH3=((HH2(:,1).^2)+(HH2(:,2).^2)).^(0.5);
% HH3(:,2)=HH3(:,1)/38;
% y=(0:0.05:1)';
% AA=histc(HH3(:,2),y);
% 
% % % PART-IV
% % %input smoothened phop_all values in 6th column and H 
% % %type II not so good
% % phop_all=phop;
% % [pks,locs,w,~]=findpeaks(phop_all(:,6),'MinpeakHeight',0.02);
% % y1=(1000:1000:12000)';
% % p_deltat=histc(w*20,y1);
% % w1=round(w/2);
% % A1=phop_all(locs,4:5);
% % A1(:,1)=A1(:,1)-w1;
% % A2=phop_all(locs,4:5);
% % A2(:,1)=A1(:,1)+w1;
% % [~,ia,~]=intersect(H(:,3:4),A1,'rows');
% % A11=H(ia,:);
% % [~,ia,~]=intersect(H(:,3:4),A2,'rows');
% % A22=H(ia,:);
% % [~,ia,ib]=intersect(A11(:,4),A22(:,4));
% % A11=A11(ia,:);
% % A22=A22(ib,:);
% % A11=sortrows(A11,[4 3]);
% % A22=sortrows(A22,[4 3]);
% % A3=A22-A11;
% % r=(A3(:,1).^2+A3(:,2).^2).^(0.5);
% % r=r/38;
% % y2=(0:0.05:1)';
% % p_deltar=histc(r,y2);

% PART - III and IV new full width of the peaks
%use smoothed profiles
clearvars -except phop_all H
phop=phop_all;
A=accumarray(phop(:,5),1);
f=find(A>10);
Lia=ismember(phop(:,5),f);
phop=phop(Lia,:);
A=accumarray(phop(:,5),phop(:,1),[],@min);
phop(:,6)=phop(:,1)-A(phop(:,5));
phop(:,7)=phop(:,6);
BB=unique(phop(:,5));
h=0.02;
d=0.001;
dia=21.7;
% TR=[]; %collecting distance between peaks
PDR1=[]; PDR2=[]; PDR=[];
PDT=[];
% BB(i)
for i=1:1:length(BB)
    f=phop(:,5)==BB(i);
    A=phop(f,:);
%     A(:,7)=smooth(A(:,6),20);
    pks=[]; pks1=[];
    [pks(:,1),pks(:,2)]=findpeaks(A(:,7),'MinpeakHeight',h,'Threshold',0.0001);
    pks(:,2)=A(pks(:,2),4);
    if isempty(pks)==1 && max(A(:,7))>=h
        [pks(1,1),pks(1,2)]=max(A(:,7));
        pks(1,2)=A(pks(1,2),4);
    end
    if A(1,7)>h
        pks(end+1,:)=A(1,[7, 4]);
    end
    if A(end,7)>h
        pks(end+1,:)=A(end,[7, 4]);
    end
    if isempty(pks)==0
        % finding minimum values
        B=0.15-A(:,7);
        [pks1(:,1),pks1(:,2)]=findpeaks(B);
        pks1(:,1:2)=A(pks1(:,2),[7, 4]);
        f=pks1(:,1)>=d;
        pks1(f,:)=[];
        if isempty(pks1)==1 && min(A(:,7))<=d
            [pks1(1,1),pks1(1,2)]=min(A(:,7));
            pks1(1,1:2)=A(pks1(1,2),[7 4]);
        end
        f=pks1(:,1)>=d;
        pks1(f,:)=[];
        % pks and pks1 are l*2 matrices, first column contains phop values
        % and 2nd column contains actual frame nos
        a=isempty(pks1);
        if a==0
            if length(pks(:,1))==1
                [D1,D2]=pdist2(pks1(:,2),pks(:,2),'euclidean','Smallest',1); 
                %distance for nearest points of elements in pks(:,2), it will have length of pks(:,2)
                %D1 contains nearest neighbour distance to points in
                %pks(:,2) and D2 contains locations of those points in pks1(:,2)
                % will get 1 deltat value and 1 deltar value
                %distance gives deltat value i.e D1
                PDT=vertcat(PDT,2*D1);
                PDR1=vertcat(PDR1,[pks(:,2),D1,pks(:,2)-D1,BB(i)]);
                PDR2=vertcat(PDR2,[pks(:,2),D1,pks(:,2)+D1,BB(i)]);
            else
                [D1,D2]=pdist2(pks1(:,2),pks(:,2),'euclidean','Smallest',1);
                for j=1:1:length(pks1(:,2))
                    f=(D2==j);
                    E=pks(f,:);
                    E(:,3)=E(:,2)-pks1(j,2);
                    if length(E(:,1))>1
                        E=sortrows(E,-1); 
                        f=sign(E(:,3))==sign(E(1,3)) & E(:,3)~=E(1,3);
                        E(f,:)=[];    
                    end
                    E(:,4)=BB(i);
                    PDT=vertcat(PDT,2*abs(E(:,3)));
                    PDR1=vertcat(PDR1,[E(:,2),abs(E(:,3)),(E(:,2)-abs(E(:,3))),E(:,4)]);
                    PDR2=vertcat(PDR2,[E(:,2),abs(E(:,3)),(E(:,2)+abs(E(:,3))),E(:,4)]);
                end
            end
        end 
    end
end
[~,ia,ib]=intersect(H(:,3:4),PDR1(:,[3,4]),'rows');
I=[H(ia,:),PDR1(ib,1:2)];
[~,ia,ib]=intersect(H(:,3:4),PDR2(:,[3,4]),'rows');
J=[H(ia,:),PDR2(ib,1)];
[~,ia,ib]=intersect(I(:,[5, 4]),J(:,[5,4]),'rows');
K=[I(ia,:),J(ib,1:3)];
K(:,10)=((K(:,1)-K(:,7)).^2+(K(:,2)-K(:,8)).^2).^(0.5);
K(:,11)=K(:,10)/dia;
y1=(0:1000:12000)';
y2=(0:0.05:1.2)';
Pdeltat=histc(PDT,y1);
Pdeltar=histc(K(:,11),y2);

% PART-II average residence time
clearvars -except phop_all
phop_all=sortrows(phop_all,[5,4]);
phop=phop_all;
A=accumarray(phop(:,5),phop(:,1),[],@min);
phop(:,6)=phop(:,1)-A(phop(:,5));
y=(0.0001:0.0005:1.2)';
A=unique(phop(:,5));
phop1=[];
for i=1:1:length(A)
    f=phop(:,5)==A(i);
    B=phop(f,:);
    B(:,6)=smooth(B(:,6),50);
    [~,locs]=findpeaks(B(:,6));
    if isempty(locs)==1
        [~,a]=max(B(:,6));
        C=zeros(1,2);
        C(1,1)=1;
        [~,b]=min(B(:,6));
        C(1,2)=2*abs((a-b));
        phop1=vertcat(phop1,[B(a,[6 4 5]),C]);
    elseif length(locs)==1
        [~,locs1]=findpeaks(-B(:,6));
        if isempty(locs1)==1 || min(B(locs1,6))>0.001
            [~,b]=min(B(:,6));
            if min(B(:,6))<0.003
                C=zeros(1,2);
                C(1,1)=1;
                C(1,2)=2*abs((a-b));
                phop1=vertcat(phop1,[B(locs,[6 4 5]),C]);
            end
        else
            E=B(locs1,[6 4 5]);
            f=E(:,1)>=0.001;
            E(f,:)=[];
            if isempty(E)==0
                [d,~]=pdist2(E(:,2),B(locs,4),'euclidean','Smallest',1);
                C=zeros(1,2);
                C(1,1)=1;
                C(1,2)=2*d;
                phop1=vertcat(phop1,[B(locs,[6 4 5]),C]);
            end
        end
    else
        %this is the case where there are more than one peak present
         [~,locs1]=findpeaks(-B(:,6));
         F=B(locs1,[6 4 5]);
         f=F(:,1)>0.001;
         F(f,:)=[];
         if isempty(F)==0
             [~,b]=min(B(:,6));
             F=B(b,[6 4 5]);
         end
         BB=B(locs,[6 4 5]);
%          [G1,G2]=pdist2(BB(:,2),BB(:,2),'euclidean','Smallest',2);
         [I1,I2]=pdist2(F(:,2),BB(:,2),'euclidean','Smallest',1);
%          G1=G1(2,:); 
%          G2=G2(2,:);
         J=[];
         for j=1:1:length(F(:,1))
             f=(I2==j);
             J1=BB(f,:);
%              J1(:,4)=BB(:,2)-BB(1,2);
             J1(:,4)=BB(:,2)-F(j,2);
             J1=sortrows(J1,-1);
             f=sign(J1(:,4))==sign(J1(1,4)) & J1(:,4)~=0;
             J1(f,:)=[];   
             if isempty(J1)~=0
                 J=vertcat(J,J1);
             end
         end
         if isempty(J)==0
             if length(J(:,1))==1
                 J(:,5)=2*abs(J(:,4));
                 J(:,4)=1;
                 phop1=vertcat(phop1,J);
             else
                 J(:,5)=2*abs(J(:,4));
                 J(:,4)=2;
                 phop1=vertcat(phop1,J); 
             end
         end
    end
end
a1=zeros(3,length(y));
for i=1:1:length(y) 
    f=phop1(:,1)>=y(i);
    phop2=phop1(f,:);
    f=phop2(:,4)==1;
    a1(1,i)=mean(phop2(f,5));
    f=phop2(:,4)==2;
    phop3=phop2(f,:);
    AA=accumarray(phop3(:,3),1);
    f=find(AA>1);
    Lia=ismember(phop3(:,4),f);
    phop4=phop3(Lia,:);
    phop4=sortrows(phop4,[3 2]);
    phop5=circshift(phop4,1);
    phop6=phop4-phop5;
    f=phop6(:,3)==0;
    a1(2,i)=mean(abs(phop6(f,2)));
    Lia=~Lia;
    a1(3,i)=mean(phop3(Lia,5));
    t_res_av(i,1)=nanmean(nonzeros(a1));
end