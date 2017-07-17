%======================================
% ����� �������� � �������� ������ � ������� � �������
% ������ ������� � ������ ������������ � �������������� ��������� EPOC+
% � ������-����������������� ������-������������� ���������� ������ 
% ������� ���������� ����-��� ����.
% �������� ������.
% https://www.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html
% 
% ������� ������ am.syskov@gmail.com
% 06072017
%======================================

% �������� ����� ������ ���, ������� �������� ������ ����� ������
filename = '.\data\Borisov_0906\Borisov_0906_rawdata_stage_5.txt';
delimiterIn = ' ';
hrvRawArray = importdata (filename,delimiterIn); 
hrvRawSize = size(hrvRawArray); %������ [����� �����,����� ��������]

%��������� �������
hrvTimeArray = hrvRawArray(1:hrvRawSize(1),1); % ������� ������� s
hrvRRArray = hrvRawArray(1:hrvRawSize(1),2); % �������� RR
hrvTimeRRArray = [hrvTimeArray,hrvRRArray]; % ����� � RR

%�������� ������� � ������ � �������������� ����
hrvOutlierArray = isoutlier3sigma(hrvRRArray, length(hrvRRArray));
outlierCount = length(find(hrvOutlierArray(:,2) == 1));
hrvTimeRRMarksOutliersArray = [hrvTimeArray, hrvOutlierArray];
[pathStr,fileStr,extStr] = fileparts(filename);
fileForSave = [pathStr,'\',fileStr,'_outliermarks_(',int2str(outlierCount),')',extStr];
dlmwrite(fileForSave,hrvTimeRRMarksOutliersArray,' ');


