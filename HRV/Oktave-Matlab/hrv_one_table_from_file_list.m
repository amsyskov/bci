## Copyright (C) 2017 a.m.syskov
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Script builds one table from files in folder. The table contains filename 
## and HF/TP, LF/TP, VLF/TP values for different subjects or stages.

## Author: a.m.syskov <a.m.syskov@SK5-900-W01>
## Created: 2017-08-07

% Create file list from folder
folderName = 'hrvfiles_for_one_table';
filesListArr = dir([folderName, '\*.txt']);
nFiles = length(filesListArr);

delimiterIn = ' ';

% Create the table with data
fieldNameCell = {'Subject', 'HF/TP', 'LF/TP', 'VLF/TP', 'LF/HF', '(HF+LF)/VLF', 'LF/VLF'};
subjCell = cell(nFiles,1);
hftpArr = zeros(nFiles,1);
lftpArr = zeros(nFiles,1);
vlftpArr = zeros(nFiles,1);
lfhfArr = zeros(nFiles,1);
hflfvlfArr = zeros(nFiles,1);
lfvlfArr = zeros(nFiles,1);
for i = 1:nFiles
  subjCell(i,1) = filesListArr(i).name;
  hrvArr = importdata ([folderName,'\',filesListArr(i).name],delimiterIn); 
  [fArr,specArr, valHF, valLF, valVLF] = hrvfreq(hrvArr(1:end,1:2));
  valTP = valHF + valLF + valVLF;
  hftpArr(i,1) = valHF/valTP;
  lftpArr(i,1) = valLF/valTP;
  vlftpArr(i,1) = valVLF/valTP;
  lfhfArr(i,1) = valLF/valHF;
  hflfvlfArr(i,1)= (valHF + valLF)/valVLF;
  lfvlfArr(i,1) = valLF/valVLF;
end
%Open file for data write
fileName = [folderName,'\','hrv_hf_lf_vlf.csv'];
fileID = fopen(fileName,'w');
%Write header string
fprintf(fileID,'%s %s %s %s %s %s %s\n','Subject', 'HF/TP', 'LF/TP', 'VLF/TP', 'LF/HF', '(HF+LF)/VLF', 'LF/VLF');
%Write data
for i = 1:nFiles
  fprintf(fileID,'%s %f %f %f %f %f %f\n',char(subjCell(i,1)),hftpArr(i,1),lftpArr(i,1),vlftpArr(i,1),lfhfArr(i,1),hflfvlfArr(i,1),lfvlfArr(i,1));
end
fclose('all');

