clear all
close all
load ('X:\bvi\!test\EPOC+\EEGEEG_Results.mat')
M1=EEGEEGResults(1:5:end,:);
M2=EEGEEGResults(3:5:end,:);
M=vertcat(M1,M2);
[coeff,score,latent]=pca(M);
for i =1:17
    figure(i);
    title ('i')
    scatter(1:9,score(1:9,i),'rs');
    %m1=mean(score(1:9)
hold on
scatter(10:18,score(10:18,i),'b*');
end