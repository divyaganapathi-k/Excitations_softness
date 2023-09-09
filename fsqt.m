%to find the fsqt of the system
%load the dedrifted results and start
% clear all
% close all
% fid = fopen('D:\Data-Divya\coding\Results-unpinnedafterdrift20(0.1).txt');
% R=fscanf(fid, '%f %f %f %f',[4 inf]);
% fclose(fid);
% R=R';
% H=drift_loop(R,20);
% H=R;
a=length(H(:,1)); %R is the dedrifted matrix which is the input to this program
b=max(H(:,3));
m=1;
q=(2*3.14)/(24.955);
fsq=[]; fs=[];
k=1;
for i=1:1:5
    for j=k:k:9*k
%         j
        D=circshift(H,-j);
        A=D-H;
        F=find(A(:,3)==j & A(:,4)==0);
        D=[]; 
        D(:,1:2)=A(F,1:2);
        c=length(D);
        if c~=0
            D=D';
%             D=(8.94*10^-6)*D;
            D=D.*D;
            D=(sum(D)).^(0.5);
            D=exp(1i*q*D);
            r=sum(D);  
            fsq(m,1)=r/c;
        else
            fsq(m,1)=0;
        end
        fs(m,2)=abs(fsq(m,1));
        fs(m,1)=j;
        m=m+1;
    end
    k=10*k;
end
% fid=fopen('E:\Shreyas-Dataanalysis\Analysis\Data-7\fsqt-Data7.txt','w+');
% fprintf(fid, '%f\t%f \r\n',fs');
% fclose(fid);