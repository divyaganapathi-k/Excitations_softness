clearvars -except pos_lst1 req_coor
req_coor=req_coor(:,1:5);
req_coor=horzcat(req_coor,pos_lst1(:,1:2));
f=req_coor(:,2)>141 & req_coor(:,3)>141 & req_coor(:,2)<1409 & req_coor(:,3)<809;
req_coor1=req_coor(f,:);
sigmas=21.7;
req_coor1(:,6:7)=req_coor1(:,6:7)./sigmas;
req_coor1(:,6:7)=ceil(req_coor1(:,6:7));
req_coor1(:,8)=sub2ind([max(req_coor1(:,6)) max(req_coor1(:,7))],req_coor1(:,6),req_coor1(:,7));
A=accumarray(req_coor1(:,8),req_coor1(:,5),[],@mean);
A(end+1:max(req_coor1(:,6))*max(req_coor1(:,7)))=0;
B=reshape(A,[max(req_coor1(:,6)) max(req_coor1(:,7))]);
B=B';
figure
% imagesc(B);
contourf(B,'LineColor','none');
set(gcf,'WindowStyle','docked')
axis equal
set(gca, 'YDir','normal')
set(gca,'TickDir','out');
colormap(jet)
caxis([-2 2])
print('H:\DF_ML\Images\soft_values_av_boxes\83.8\W8_83.8.tif','-dtiff','-r300');
% a=(1:1:max(req_coor1(:,6)))';
% b=(1:1:max(req_coor1(:,7)))';
% B(:,1)=repelem(a,max(req_coor1(:,7)));
% B(:,2)=repmat(b,max(req_coor1(:,6)),1);
% B(:,3)=sub2ind([max(req_coor1(:,6)) max(req_coor1(:,7))],B(:,1),B(:,2));
% A(end+1:numel(B(:,1)))=0;
% B(:,4)=A(B(:,3));
% pcolor(B(:,1),B(:,1),B(:,4));
% imagesc(B(:,1),B(:,1),B(:,4));