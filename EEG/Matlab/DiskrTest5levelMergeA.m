clear all
close all
load ('X:\bvi\!test\EPOC+\Mat\GlobalIndexes.mat')
M1=EEGEEGResultsG(:,[1,2,17,18, 25,26,37,38,53,54]);%(:,[1,2,3,4,17,18,19,20, 25,26,27,28, 37,38,39,40, 53,54,55,56]);%[1,2,17,18, 25,26,37,38,53,54])
load ('X:\bvi\!test\EPOC+\Mat\AccF.mat')
M2=Accefeatures(:,[1, 9,15,22]);%]
%Нормировка MD
for i=1:size(M2,2)
    M2(:,i)=M2(:,i)/max(M2(:,i));
end
M=horzcat(M1,M2);
%M=M2;

%Набор функциональных состояний 5 независимых:FR-T1-HV-T2-AE или 3 повторяющихся:F-T-HV-T-F
%group = [1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5]';
group = [1,2,3,2,1,1,2,3,2,1,1,2,3,2,1,1,2,3,2,1,1,2,3,2,1,1,2,3,2,1,1,2,3,2,1,1,2,3,2,1,1,2,3,2,1]';
loocv=zeros(4,length(group));
for n =1:length(group)
    Strain=M;
    Strain(n,:)=[];
    gtrain=group;
    gtrain(n)=[];
    Stest=M(n,:);
    gtest=group(n);
    
% Linear discriminant classifier
    lda = fitcdiscr(Strain,gtrain);
    loocv(1,n)=predict(lda,Stest);
    ldaResubErr = resubLoss(lda);
    ErrLDA(n)=ldaResubErr;

% Quadratic classifier
  %       qda=fitcdiscr(Strain,gtrain,'DiscrimType','diagquadratic');
  %       loocv(2,n)=predict(qda,Stest);

% Naive Bayess classifier
          nbGau = fitcnb(Strain,gtrain);
          loocv(3,n)=predict(nbGau,Stest);

 %Classification tree
    ctree = fitctree(Strain,gtrain);
    loocv(4,n)=predict(ctree,Stest);
end
c1=confusionmat(group,loocv(1,:))'
S1=confusionmatStats(group,loocv(1,:));
a(1)=mean(S1.accuracy)
%c2=confusionmat(group,loocv(2,:))'
%S2=confusionmatStats(group,loocv(2,:));
%mean(S2.accuracy)
c3=confusionmat(group,loocv(3,:))'
S3=confusionmatStats(group,loocv(3,:));
a(2)=mean(S3.accuracy)
c4=confusionmat(group,loocv(4,:))'
S4=confusionmatStats(group,loocv(4,:));
a(3)=mean(S4.accuracy)
e=2.718281828459045