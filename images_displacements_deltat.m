clearvars -except H R
t=30;
sigmas=21.7;
a=0.5*sigmas;
H1=circshift(H,t);
H2=H-H1;
H2(:,5)=(H2(:,1).^2+H2(:,2).^2).^(0.5);
H2(:,5)=H2(:,5)/a;
H2(:,1:2)=H(:,1:2);
H2(:,6)=5*((R(:,3)).^(0.5));
H2(:,7)=1;
H2(:,8)=H(:,3);
f=H2(:,3)==t & H2(:,4)==0;
H2=H2(f,:);
f=H2(:,8)==2000;
% S= 0.1*max(H2(:,1))*ones(length(H2(:,1)),1);
% figure
% scatter3sph(H2(f,1),H2(f,2),H2(f,7),'size',H2(f,6));
scatter(H2(f,1),H2(f,2),H2(f,6),H2(f,5),'filled');
colormap(jet);
caxis([0 1]);
axis equal
axis([0 1450 0 900])
set(gca,'TickDir','out');
% 'color',H2(f,5)
