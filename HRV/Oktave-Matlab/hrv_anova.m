filename = '.\manova\groups.csv';
delimiterIn = ';';
rowArr = importdata (filename,delimiterIn);
varCell = {'Subject', 'HF/TP', 'LF/TP', 'VLF/TP', 'LF/HF', '(HF+LF)/VLF', 'LF/VLF'}; 
nVar = size(rowArr)(2); 

[pathStr,fileStr,extStr] = fileparts(filename);
fileName = [pathStr,'\','anova.txt'];
fileID = fopen(fileName,'w');

for i = 2:nVar % First is group ID
  [PVAL, F, DF_B, DF_W] = anova(rowArr(1:end, i), rowArr(1:end, 1));
  fprintf(fileID,"============= %s ================ \n", char(varCell(i)));
  fprintf(fileID,"F = %f; P = %f \n", F,PVAL);
end
fclose('all');
stgArr = unique(rowArr(1:end, 1));
nStg = length(stgArr);
for i = 2:nVar
  for j=1:nStg
    tmpArr = rowArr(rowArr(1:end, 1) == stgArr(j,1),i);
    if j==1 
      varStgArr = zeros(length(tmpArr), nStg);
    endif
    varStgArr(1:end,j) = tmpArr;
  end
  boxplot(varStgArr);
  title(['Var: ',varCell(i)])
  xlabel('Stages: 1-rest, 2-TOVA, 3-hyper ventelation, 4-TOVA, 5-after tests state')
  ylabel('Index')  
end