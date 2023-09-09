%MSD using circshift
%clearvars -except R
% H=[];
% H=drift_loop(R,80);
% add dedrifting part
% close all
% clear all
% fid = fopen('G:\Results-unpinnedhifi.txt');
% R=fscanf(fid, '%f %f %f %f',[4 inf]);
% fclose(fid);
% R=R';
% H=drift_loop(R,40);
% H=H1;
% f=(H(:,3)>=1000);
% H=H(f,:);
clearvars -except H
% H=sortrows(H,[4 3]);
a=length(H(:,1)); %H is the dedrifted matrix which is the input to this program
b=max(H(:,3));
Dx=zeros(1,b);
Dy=zeros(1,b);
Dxx=zeros(1,b);
Dyy=zeros(1,b);
D=zeros(1,b);
count=zeros(1,b);
deltat=zeros(1,b);
m=1;
j=1;
for l=1:1:4
    for i=j:j:9*j
% for i=1:5:3000
        G=circshift(H,-i);
        A=G-H;
        B=(A(:,3)==i & A(:,4)==0);
        C=(A(B,1:2)).^2;
%         C1=[];
        C1=C(:,1)+C(:,2);
        CC=(C1).^2;
        k=length(C(:,1));
        Dx(1,m)=(sum(C(:,1)))/k;
        Dy(1,m)=(sum(C(:,2)))/k;
%         Dxx(1,m)=(sum(CC(:,1)))/k;
%         Dyy(1,m)=(sum(CC(:,2)))/k;
        D(1,m)=Dx(1,m)+Dy(1,m);
        DD(1,m)=(sum(CC))/k;
%         DD(1,m)=Dxx(1,m)+Dyy(1,m);
        count(1,m)=k;
        deltat(1,m)=i;
        m=m+1;
    end
        j=10*j;
end
% end
m=m-1;
Dx=Dx(1,1:m);
Dy=Dy(1,1:m);
D=D(1,1:m);
% Dxx=Dxx(1,1:m);
% Dyy=Dyy(1,1:m);
DD=DD(1,1:m);
alpha2=(DD./(2*((D).^2)))-1;
alpha2=alpha2';
% Reference for 2-D liquids, J. Chem. Phys. 105, 10521 (1996), Peter Harrowell
deltat=deltat(1,1:m);
count=count(1,1:m);
count=count';
msd=vertcat(deltat,D);
msd=msd';
deltat=deltat';
% res=[deltat',Dx',Dy',D'];
% fid=fopen('msd-unpinnedhifi.txt','w+');
% fprintf(fid, '%f\t%f\t%f\t%f \r\n',res');
% fclose(fid);


% radial_density(:,51)=13;
% radial_density=horzcat(radial_density(:,1:3),radial_density(:,51),radial_density(:,4:end-1));
% radial_density1=vertcat(radial_density1,radial_density);