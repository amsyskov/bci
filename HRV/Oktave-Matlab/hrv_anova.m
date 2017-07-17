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




