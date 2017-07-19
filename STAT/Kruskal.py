from scipy import stats

from os import listdir
from os.path import isfile, join



mypath='C:\ANOVA\EEG'
all_in_folder=listdir(mypath)
files_in_folder=[]
for item in all_in_folder:
    if(isfile(mypath+'\\'+item)):
        files_in_folder.append(mypath+'\\'+item)

#onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

data=[]
for path in files_in_folder:
    arr = []
    with open(path) as csv:
        for linen in csv:
            line=csv.readline().split(';')
            for i in range(len(line)):
                if ((line[i]=='')or(line[i]=='\n')):
                    del line[i]
            for i in range(len(line)):
                line[i]=float(line[i])
            arr.append(line)
        csv.close()
    if (arr[-1]==[]):
        del arr[-1]
    data.append(arr)

print(data[0])

