%Longrunanalysis
FFT = rand(450,8*2^16);

for n=1:length(Idata)
   temp = abs(fft(Idata(n,:) + 1i.*Qdata(n,:)));
   FFT(n) = temp(length(temp)/2+1:end);
end


numofbins= 65536*8;
samplingfreq = 5000000; %sampling freq in Hz

maxfreq=samplingfreq/2;
xaxis = linspace(((numofbins-1)/(numofbins))*-maxfreq,((numofbins-1)/(numofbins))*maxfreq,numofbins);

mesh(FFT);