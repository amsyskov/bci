%======================================
% ������� ����� ��� �� ������ � ���������� � ����� _rawdata_stage_(����� ������)
% � ����� � �������� ������.
% ������ ������� � ������ ������������ � �������������� ��������� EPOC+
% � ������-����������������� ������-������������� ���������� ������ 
% ������� ���������� ����-��� ����.
% 
% ������� �������� ��� ����� ����� �������.
% ������� ����������� ������������:
%   5 ���. ��
%   �������� 3 ���. TOVA ����. ������ ����� ����� ����� �� ����� TOVA �����.
%   3 ���. �������������������� �����.
%   �������� 3 ���. TOVA. ������ ����� ����� ����� �� ����� TOVA �����.
%   5 ���. �������������.
%
% ������� ������ am.syskov@gmail.com
% 06072017
%======================================

% �������� ����� ������ ���.
% ��� �������� �� ��������� ����� ��������� ���������.
% ���� �������� 3 �������: �����(��), ��� - I:���, ��� - I:RR
filename = '.\data\Borisov_0906\Borisov_0906.txt';
delimiterIn = ' ';
hrvRawArray = importdata (filename,delimiterIn); 
hrvRawSize = size(hrvRawArray); %������ [����� �����,����� ��������]

%��������� �������
hrvTimeArray = hrvRawArray(1:hrvRawSize(1),1); % ������� ������� s
hrvRRArray = hrvRawArray(1:hrvRawSize(1),3); % �������� RR
hrvTimeRRArray = [hrvTimeArray,hrvRRArray]; % ����� � RR

%��������� �� ���������
stageEndTimeArray = [5,8,11,14,19] * 60000; %����� ���������� ms.
stageTimeRRCell = cell(length(stageEndTimeArray),1); %�������� ������� ��� ������.
for i = 1:length(stageEndTimeArray)
  % ��������� ������ ������� ����� ��������� ������
  if i > 1 
    indexStageArray = hrvTimeRRArray(:,1)<stageEndTimeArray(i) & hrvTimeRRArray(:,1)>=stageEndTimeArray(i-1);
  else
    indexStageArray = hrvTimeRRArray(:,1)<stageEndTimeArray(i); 
  end
  %���������� � ������ ������ ����� � RR ��� ��������� ������
  stageTimeRRCell{i} = hrvTimeRRArray(indexStageArray,:);
end

%��������� ��������� � �����
[path,file,ext] = fileparts(filename);
for i = 1:length(stageTimeRRCell)
  fileForSave = [path,'\',file,'_rawdata_stage_',int2str(i),ext];
  dlmwrite(fileForSave, stageTimeRRCell{i}, delimiterIn);
end



%���� ������� � ������ � �������������� ����
%hrvOutlierArray = isoutlier3sigma(hrvRRArray,6);
%hrvTimeRRMarksOutliersArray = [hrvTimeArray, hrvOutlierArray];
%dlmwrite('outlier.txt',hrvTimeRRMarksOutliersArray,' ');

%������������ ������ ��� ������������ �������


