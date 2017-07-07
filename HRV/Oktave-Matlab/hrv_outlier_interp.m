%======================================
% �������� �������� � �������� ������� �������� �������������. 
% ������ ������� � ������ ������������ � �������������� ��������� EPOC+
% � ������-����������������� ������-������������� ���������� ������ 
% ������� ���������� ����-��� ����.
% �������� ������.
% https://www.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html
% https://habrahabr.ru/post/257345/
% https://www.mathworks.com/help/matlab/ref/interp1.html
%
% ������� ������ am.syskov@gmail.com
% 06072017
%======================================

% ������ ������ �� ����� ��� ��� ����� ������
filename = '.\data\Purtov_0906\purtov_hrv_data_only_rawdata_stage_1_outliermarks_.txt';
delimiterIn = ' ';
hrvRawArray = importdata (filename,delimiterIn); 
hrvRawSize = length(hrvRawArray); %������ [����� �����,����� ��������]
%��������� �������
hrvClearDataIdxArray = find(hrvRawArray(:,3) == 0); % ������� ����� ��� ��������.
hrvClearArray = hrvRawArray(hrvClearDataIdxArray,:); % ������ ��� ��������.
%�������� ������ �����, � ������� �������� ��������.
hrvFixedOutlierArray = interp1(hrvClearArray(:,1), hrvClearArray(:,2), hrvRawArray(:,1));
hrvFixedDataArray = [hrvRawArray(:,1),hrvFixedOutlierArray(:,1)];
%��������� ���������� ��������� � ����
[pathStr,fileStr,extStr] = fileparts(filename);
fileForSave = [pathStr,'\',fileStr,'fixed',extStr];
dlmwrite(fileForSave,hrvFixedDataArray,' ');
