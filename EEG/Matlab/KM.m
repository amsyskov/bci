close all
clear all
load ('X:\bvi\!test\EPOC+\MergeTOVA.csv')
figure;
plot(MergeTOVA(1:9,2),MergeTOVA(1:9,3),'r*','MarkerSize',5);
hold on
plot(MergeTOVA(9:18,2),MergeTOVA(9:18,3),'bs','MarkerSize',5);
title 'TOVA-test';
xlabel 'Omission Errors';
ylabel 'Commision Errors';
%rng(1); % For reproducibility
[idx,C] = kmeans(MergeTOVA(:,2:4),2);
coeff=pca(MergeTOVA(:,2:4));
