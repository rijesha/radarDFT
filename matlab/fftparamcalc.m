%how fft works
function explicitperiod = fftparamcalc(maxfreq, binwidth, clockspeed, bramblocksize)

samplingfreq = maxfreq*2

numbofbins = samplingfreq/binwidth

%calculate closest 2^n
found = 0;
n=0;
while found == 0
    n = n+1;
if ((2^(n-1) < numbofbins) && (2^(n) > numbofbins))
    found = 1;
end

end
numbofbins = 2^n

binwidth = samplingfreq/numbofbins

timeperiod = 1/binwidth

explicitperiod = clockspeed/samplingfreq

timetofillbram = bramblocksize/samplingfreq

numofdatapoints = timetofillbram/timeperiod

