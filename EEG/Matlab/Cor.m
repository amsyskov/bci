 close all
 clear all
load ('X:\bvi\!test\EPOC+\Corr VLF+EEG.mat')
CCT=[000000000];
AF_Theta=(IED_AF3_Theta+IED_AF4_Theta)/2;
O_Theta=(IED_O1_Theta+IED_O2_Theta)/2;
T_Theta=(AF_Theta+O_Theta)/2;
for i = 0:8
    AO=corrcoef(VLFTP(5*i+1:5*i+5,1),O_Theta(5*i+1:5*i+5,1));
    AF=corrcoef(VLFTP(5*i+1:5*i+5,1),AF_Theta(5*i+1:5*i+5,1));
    T=corrcoef(VLFTP(5*i+1:5*i+5,1),T_Theta(5*i+1:5*i+5,1));
    CCT(1,i+1)=AO(2,1);
    CCT(2,i+1)=AF(2,1);
    CCT(3,i+1)=T(2,1);
end
 CCA=[000000000];
AF_Alpha=(IED_AF3_Alpha+IED_AF4_Alpha)/2;
O_Alpha=(IED_O1_Alpha+IED_O2_Alpha)/2;
T_Alpha=(AF_Alpha+O_Alpha)/2;
for i = 0:8
    AO=corrcoef(VLFTP(5*i+1:5*i+5,1),O_Alpha(5*i+1:5*i+5,1));
    AF=corrcoef(VLFTP(5*i+1:5*i+5,1),AF_Alpha(5*i+1:5*i+5,1));
    T=corrcoef(VLFTP(5*i+1:5*i+5,1),T_Alpha(5*i+1:5*i+5,1));
    CCA(1,i+1)=AO(2,1);
    CCA(2,i+1)=AF(2,1);
    CCA(3,i+1)=T(2,1);
end
  CCB=[000000000];
AF_Beta=(IED_AF3_BetaL+IED_AF3_BetaH+IED_AF4_BetaL+IED_AF4_BetaH)/2;
O_Beta=(IED_O1_BetaL+IED_O1_BetaH+IED_O2_BetaL+IED_O2_BetaH)/2;
T_Beta=(AF_Beta+O_Beta)/2;
for i = 0:8
    AO=corrcoef(VLFTP(5*i+1:5*i+5,1),O_Beta(5*i+1:5*i+5,1));
    AF=corrcoef(VLFTP(5*i+1:5*i+5,1),AF_Beta(5*i+1:5*i+5,1));
    T=corrcoef(VLFTP(5*i+1:5*i+5,1),T_Beta(5*i+1:5*i+5,1));
    CCB(1,i+1)=AO(2,1);
    CCB(2,i+1)=AF(2,1);
    CCB(3,i+1)=T(2,1);
end
 CCAcc=[000000000];
for i = 0:8
    Acc=corrcoef(VLFTP(5*i+1:5*i+5,1),AccM(5*i+1:5*i+5,1));
    CCAcc(1,i+1)=Acc(2,1);
end
 