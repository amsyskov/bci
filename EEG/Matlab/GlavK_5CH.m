clear all
close all
load ('X:\bvi\!test\EPOC+\EEGEEG_Results.mat')
F3B=EEGEEGResults(1:5:end,9:12);
F4B=EEGEEGResults(1:5:end,44:47);
T7B=EEGEEGResults(1:5:end,17:20);
T8B=EEGEEGResults(1:5:end,36:39);
OB=(EEGEEGResults(1:5:end,24:27)+EEGEEGResults(1:5:end,28:31))/2;
F3H=EEGEEGResults(3:5:end,9:12);
F4H=EEGEEGResults(3:5:end,44:47);
T7H=EEGEEGResults(3:5:end,17:20);
T8H=EEGEEGResults(3:5:end,36:39);
OH=(EEGEEGResults(3:5:end,24:27)+EEGEEGResults(3:5:end,28:31))/2;
B=horzcat(F3B,F4B,T7B,T8B,OB);
H=horzcat(F3H,F4H,T7H,T8H,OH);
M=vertcat(B,H);
[coeff,score,latent]=pca(M);
for i =1:17
    figure(i);
    title ('i')
    scatter(1:9,score(1:9,i),'rs');
    %m1=mean(score(1:9)
hold on
scatter(10:18,score(10:18,i),'b*');
end
% 