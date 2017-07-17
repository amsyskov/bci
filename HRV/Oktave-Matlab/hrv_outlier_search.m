%======================================
% Поиск выбросов и выгрузка данных с отмекой о выбросе
% Скрипт написан в рамках исследований с использованием гарнитуры EPOC+
% в Научно-исследовательском медико-биологическом инженерном центре 
% высоких технологий ИРИТ-РТФ УРФУ.
% Полезные ссылки.
% https://www.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html
% 
% Алексей Сысков am.syskov@gmail.com
% 06072017
%======================================

% Открытие файла данных ВСР, который содержит данные одной стадии
filename = '.\data\Borisov_0906\Borisov_0906_rawdata_stage_5.txt';
delimiterIn = ' ';
hrvRawArray = importdata (filename,delimiterIn); 
hrvRawSize = size(hrvRawArray); %массив [число строк,число столбцов]

%Формируем массивы
hrvTimeArray = hrvRawArray(1:hrvRawSize(1),1); % отсчеты времени s
hrvRRArray = hrvRawArray(1:hrvRawSize(1),2); % значения RR
hrvTimeRRArray = [hrvTimeArray,hrvRRArray]; % время и RR

%Отмечаем выбросы в данных с использованием окна
hrvOutlierArray = isoutlier3sigma(hrvRRArray, length(hrvRRArray));
outlierCount = length(find(hrvOutlierArray(:,2) == 1));
hrvTimeRRMarksOutliersArray = [hrvTimeArray, hrvOutlierArray];
[pathStr,fileStr,extStr] = fileparts(filename);
fileForSave = [pathStr,'\',fileStr,'_outliermarks_(',int2str(outlierCount),')',extStr];
dlmwrite(fileForSave,hrvTimeRRMarksOutliersArray,' ');


