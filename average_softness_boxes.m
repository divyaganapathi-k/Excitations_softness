clearvars -except req_coor
%train output should have dedrifted coordinates
% req_coor=horzcat(req_coor,pos_lst1(:,1:2));
boxsiz=4;
sigmas=21.7;
x=1500;
y=900;
b=3*6*5;
av_soft_cont=[];
av_soft_whole=zeros((max(req_coor(:,4))-b),1);
f=req_coor(:,6)>=0 & req_coor(:,7)>=0 & req_coor(:,6)<=1500 & req_coor(:,7)<=900;
req_coor=req_coor(f,:);
req_coor(:,8)=(floor(req_coor(:,6)/(boxsiz*sigmas))+1);
req_coor(:,9)=(floor(req_coor(:,7)/(boxsiz*sigmas))+1); 
% f=req_coor(:,8)>0 & req_coor(:,9)>0 & req_coor(:,8)<37 & req_coor(:,9)<23;
% req_coor=req_coor(f,:);
req_coor(:,10)=sub2ind([max(req_coor(:,8)) max(req_coor(:,9))],req_coor(:,8),req_coor(:,9));
for i=1:1:max(req_coor(:,4))
    f=req_coor(:,4)>=i & req_coor(:,4)<i+b;
    A=accumarray(req_coor(f,10),req_coor(f,5),[],@mean);
     if length(A)<198
        A(end+1:198,1)=0;
     end
    av_soft_cont=horzcat(av_soft_cont,A);
    av_soft_whole(i,1)=mean(req_coor(f,5));
end
