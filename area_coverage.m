clearvars
close all
A=imread('H:\DF_ML\W7_soft_W4_whole.tif');
B=A(:,:,1);
figure
imagesc(B)
load('cmap_hard_soft.mat')
colormap(cmap)
% C=roicolor(B,0,180);
C=roicolor(B,140,256);
figure
imagesc(C)
sum(sum(C))
