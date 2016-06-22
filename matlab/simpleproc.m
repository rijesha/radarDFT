%% simple proc

rmdc = 1;
figure;
bramsize = 65536;
FFT = {};
numofbins = bramsize/16;
maxfreq = 5000;
xaxis = linspace(((numofbins-1)/(numofbins)),((numofbins-1)/(numofbins))*maxfreq*2,numofbins);


for log=1:(numel(Idata)/length(Idata))
    
     Itmp = Idata(log,:);
     Qtmp = Qdata(log,:);
     if rmdc == 1
        Itmp = Itmp - mean(Itmp);
        Qtmp = Qtmp - mean(Qtmp);
    end
    tmp = Itmp;
    for n=1:16
        tmp2 = tmp((bramsize/16*(n-1)+1):(bramsize/16*(n)));
        FFT{log}(n,:) = abs(fft(tmp2));
        plot(xaxis,FFT{log}(n,:))
        title(sprintf('log %d slice %d',log,n))
        pause(.01)
    end
end

%% Find Max
figure;
doppler = []
for log=1:(numel(Idata)/length(Idata))
    for n=1:16
        dat = FFT{log}(n,:);
        [pks srtind] = findpeaks(dat);
        [pks pksind]=sort(pks,'descend');
        
       
        ind = srtind(pksind(1));
        
        try 
        xnew = xaxis(ind-20:ind+20);
        datnew = dat(ind-20:ind+20);
        plot(xnew,datnew)
        
        
        [fpks fsrtind] = findpeaks(datnew);
        [fpks fpksind]=sort(fpks,'descend');
        ind2 = srtind(fpksind(2));
        
        doppler = [doppler, xaxis(ind) - xnew(ind2)];
        catch
            fprintf('Index failure \n');
            doppler = [doppler, 0];
        end
        title(sprintf('log %d slice %d',log,n));
        pause(.1)

    end
end
plot(doppler,1:length(doppler))