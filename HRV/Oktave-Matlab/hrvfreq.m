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

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} hrvfreq (@var{input1}, @var{input2})
## Return single-sided spectrum and sum spectral power of HRV signal [HF,LF,VLF]: 
##    HF — 0,4–0,15 Hz (2,5–6,5 s);
##    LF — 0,15–0,04 Hz (6,5–25 s);
##    VLF — 0,04–0,003 Hz (25–333 s). 
## Links:
## https://www.mathworks.com/help/matlab/ref/fft.html
## https://habrahabr.ru/post/112068/
## http://old.exponenta.ru/soft/matlab/potemkin/book2/chapter8/fft.asp
## http://www.fftw.org/
##
## @seealso{}
## @end deftypefn

## Author: a.m.syskov <a.m.syskov@SK5-900-W01>
## Created: 2017-07-07

function [freqArray, specArray1, valHF, valLF, valVLF] = hrvfreq (signalArray)
% Time vector with fixed sampling frequency
  Fs = 4;
  timeArray = signalArray(1,1):(1000/Fs):signalArray(end,1);
% Vector with values for discret signal with sampling frequence Fs
  discretSignalArray = interp1(signalArray(:,1),signalArray(:,2),timeArray,'spline');
% Discrete Fourier transform for detrended signal. 
% Identify a new input length n that is the next power of 2 from the original 
% signal length if need improve of perfomance. This will pad the signal 
% discretSignalArray with trailing zeros. 
  n = length(discretSignalArray);
%  n = 2^nextpow2(length(discretSignalArray));
  pointsDFTArr = fft(detrend(discretSignalArray),n);
% Compute the two-sided spectrum specArray2. 
% Then compute the single-sided spectrum specArray1 based on specArray2 
% and the even-valued signal length.
  specArray2 = abs(pointsDFTArr)/n;
  specArray1 = specArray2(1:n/2+1);
  specArray1(2:end-1) = 2*specArray1(2:end-1);
% Define the frequency domain freqArray. 
  freqArray = Fs*(0:(n/2))/n;
% Compute sum in HF, LF, VLF for HRV signal
  idxArr = find(freqArray(freqArray<0.4 & freqArray>0.15));
  valHF = sum(specArray1(idxArr));
  idxArr = find(freqArray(freqArray<0.15 & freqArray>0.04));
  valLF = sum(specArray1(idxArr));  
  idxArr = find(freqArray(freqArray<0.04 & freqArray>0.003));
  valVLF = sum(specArray1(idxArr));  
endfunction
