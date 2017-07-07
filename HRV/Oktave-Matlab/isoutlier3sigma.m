function outlierIndexArr = isoutlier3sigma( inputArr, windowSize )
%Поиск выбросов методом 3-х сигма для окна
    inputArrSize = length(inputArr);
    outlierIndexArr = zeros([inputArrSize,1]);
    for iWin = 1:(inputArrSize-windowSize+1)
        windowArr = inputArr(iWin:iWin+windowSize-1);
        m = median(windowArr);
        s = mad(windowArr);
        for iWinItem = iWin:iWin+windowSize-1
            if (inputArr(iWinItem)>m + 3*s) || (inputArr(iWinItem)<m - 3*s)
               outlierIndexArr(iWinItem) = 1;
            else
               outlierIndexArr(iWinItem) = 0; 
            end
        end
    end
    outlierIndexArr = [inputArr,outlierIndexArr];
end

