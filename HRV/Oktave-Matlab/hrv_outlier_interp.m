%======================================
% Заменяем значения в выбросах методом линейной интерполяцией. 
% Скрипт написан в рамках исследований с использованием гарнитуры EPOC+
% в Научно-исследовательском медико-биологическом инженерном центре 
% высоких технологий ИРИТ-РТФ УРФУ.
% Полезные ссылки.
% https://www.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html
% https://habrahabr.ru/post/257345/
% https://www.mathworks.com/help/matlab/ref/interp1.html
%
% Алексей Сысков am.syskov@gmail.com
% 06072017
%======================================

% Импорт данных из файла ВСР для одной стадии
filename = '.\data\Purtov_0906\purtov_hrv_data_only_rawdata_stage_1_outliermarks_.txt';
delimiterIn = ' ';
hrvRawArray = importdata (filename,delimiterIn); 
hrvRawSize = length(hrvRawArray); %массив [число строк,число столбцов]
%Формируем массивы
hrvClearDataIdxArray = find(hrvRawArray(:,3) == 0); % индексы строк без выбросов.
hrvClearArray = hrvRawArray(hrvClearDataIdxArray,:); % данные без выбросов.
%получаем полную сетку, в которой пропуски заменены.
hrvFixedOutlierArray = interp1(hrvClearArray(:,1), hrvClearArray(:,2), hrvRawArray(:,1));
hrvFixedDataArray = [hrvRawArray(:,1),hrvFixedOutlierArray(:,1)];
%сохраняем результаты обработки в файл
[pathStr,fileStr,extStr] = fileparts(filename);
fileForSave = [pathStr,'\',fileStr,'fixed',extStr];
dlmwrite(fileForSave,hrvFixedDataArray,' ');
