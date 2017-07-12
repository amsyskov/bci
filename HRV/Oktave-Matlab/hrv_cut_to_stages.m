%======================================
% Нарезка файла ВСР на стадии и сохранение в файлы _rawdata_stage_(номер стадии)
% в папке с исходным файлом.
% Скрипт написан в рамках исследований с использованием гарнитуры EPOC+
% в Научно-исследовательском медико-биологическом инженерном центре 
% высоких технологий ИРИТ-РТФ УРФУ.
% 
% Сигналы писались без общих меток времени.
% Базовая циклограмма исследования:
%   5 мин. ФП
%   примерно 3 мин. TOVA тест. Точное врямя нужно брать из файла TOVA теста.
%   3 мин. гипервентелляционная проба.
%   примерно 3 мин. TOVA. Точное врямя нужно брать из файла TOVA теста.
%   5 мин. последействие.
%
% Алексей Сысков am.syskov@gmail.com
% 06072017
%======================================

% Открытие файла данных ВСР.
% Для загрузки из исходного файла удаляется заголовок.
% Файл содержит 3 столбца: Время(мс), ЭКГ - I:ЧСС, ЭКГ - I:RR
filename = '.\data\Borisov_0906\Borisov_0906.txt';
delimiterIn = ' ';
hrvRawArray = importdata (filename,delimiterIn); 
hrvRawSize = size(hrvRawArray); %массив [число строк,число столбцов]

%Формируем массивы
hrvTimeArray = hrvRawArray(1:hrvRawSize(1),1); % отсчеты времени s
hrvRRArray = hrvRawArray(1:hrvRawSize(1),3); % значения RR
hrvTimeRRArray = [hrvTimeArray,hrvRRArray]; % время и RR

%разбиваем на интервалы
stageEndTimeArray = [5,8,11,14,19] * 60000; %конец интервалов ms.
stageTimeRRCell = cell(length(stageEndTimeArray),1); %содержит массивы для стадий.
for i = 1:length(stageEndTimeArray)
  % заполняем массив индекса строк указанной стадии
  if i > 1 
    indexStageArray = hrvTimeRRArray(:,1)<stageEndTimeArray(i) & hrvTimeRRArray(:,1)>=stageEndTimeArray(i-1);
  else
    indexStageArray = hrvTimeRRArray(:,1)<stageEndTimeArray(i); 
  end
  %записываем в ячейку массив время и RR для указанной стадии
  stageTimeRRCell{i} = hrvTimeRRArray(indexStageArray,:);
end

%сохраняем разбиение в файлы
[path,file,ext] = fileparts(filename);
for i = 1:length(stageTimeRRCell)
  fileForSave = [path,'\',file,'_rawdata_stage_',int2str(i),ext];
  dlmwrite(fileForSave, stageTimeRRCell{i}, delimiterIn);
end



%Ищем выбросы в данных с использованием окна
%hrvOutlierArray = isoutlier3sigma(hrvRRArray,6);
%hrvTimeRRMarksOutliersArray = [hrvTimeArray, hrvOutlierArray];
%dlmwrite('outlier.txt',hrvTimeRRMarksOutliersArray,' ');

%Интерполяция данных для последующего анализа


