%% simple proc
useQdata = 1;
rmdc = 1;
plotfullspect = 0; %plot the full raw fft spectrum
plotint = 0; %plot area of int
plotavgrm = 0; %plot are of interest mius avg
plotavgs = 0; %plot the average spectrums for each log
plotlogs = 0; %plot and overlay of the slices from each log. (will gen a lot of graphs)
drifttest = 1;


%% FFT of full spectrum
figure;
bramsize = 65536;
FFT = {};
numofbins = bramsize/16;
numberoflogs = numel(Idata)/length(Idata);
maxfreq = 5000;
xaxis = linspace(((numofbins-1)/(numofbins)),((numofbins-1)/(numofbins))*maxfreq*2,numofbins);
datarmdc = [];

for log=1:(numberoflogs)
     Itmp = Idata(log,:);
     Qtmp = Qdata(log,:);
     if rmdc == 1
        Itmp = Itmp - mean(Itmp);
        Qtmp = Qtmp - mean(Qtmp);
     end
     
    tmp = Itmp;
    if useQdata == 1
        tmp = tmp + 1i*Qtmp;
    end
    
    if rmdc == 1
        datarmdc(log,:) = tmp;
        plot(abs(fft(tmp)))
    end
    
    for n=1:16
        tmp2 = tmp((bramsize/16*(n-1)+1):(bramsize/16*(n)));
        FFT{log}(n,:) = abs(fft(tmp2));
        
        if plotfullspect
            plot(xaxis,FFT{log}(n,:))
            title(sprintf('log %d slice %d',log,n))
            pause(.01)
        end        
    end
end

%% Find Max
figure;
doppler = [];
signal = {};
for log=1:(numberoflogs)
    for n=1:16
        dat = FFT{log}(n,:);
        [pks, srtind] = findpeaks(dat);
        [pks, pksind]=sort(pks,'descend');
        
       
        ind = srtind(pksind(1));
        
        try 
        xnew = xaxis(ind-20:ind+20);
        datnew = dat(ind-20:ind+20);
        sigcol = 'b';
        pausetime = .01;
        catch
            fprintf('Index failure. Shifting signal. \n');
            dat = circshift(dat,[0 2048]);
            [pks, srtind] = findpeaks(dat);
            [pks, pksind]=sort(pks,'descend');
            ind = srtind(pksind(1));
            xnew = xaxis(ind-20:ind+20);
            datnew = dat(ind-20:ind+20);
            sigcol = 'r';
%            pausetime = .01;
        end
        
        
        if plotint
            plot(xnew,datnew,sigcol)
            title(sprintf('log %d slice %d',log,n));
            pause(pausetime)
        end
        signal{log}(n,:) = datnew;
        
        [fpks, fsrtind] = findpeaks(datnew);
        [fpks, fpksind]=sort(fpks,'descend');
        ind2 = fsrtind(fpksind(2));
        
        doppler = [doppler, xaxis(ind) - xnew(ind2)];
    end
end

%% remove average signal and calc doppler
doppler2 = [];
avgsig = cell(0,numberoflogs);
for log=1:(numberoflogs)
    avgsig{log} = zeros(1,41);
    for n=1:16
        avgsig{log} = avgsig{log} +signal{log}(n,:);
    end
    avgsig{log} = avgsig{log}/16;
    
    for n=1:16
        if plotavgrm
            plot(xnew, signal{log}(n,:)-avgsig{log});
            title(sprintf('log %d slice %d',log,n))
            pause(.01)
        end
        [mval, mind] = max(signal{log}(n,:)-avgsig{log});
        doppler2 = [doppler2, xnew(21) - xnew(mind)]; 
    end
end

figure;
hold on
plot(doppler2,linspace(0,numberoflogs,numberoflogs*16),'r')
plot(doppler,linspace(0,numberoflogs,numberoflogs*16))

%% plot averages

if plotavgs ==1
    figure;
    hold on
    for log=1:(numberoflogs)
        plot(avgsig{log})
        pause(.1)
    end
end

%% plot logs and averaged

if plotlogs ==1
    for log=1:(numberoflogs)
        figure;
        title(sprintf('log %d',log))
        hold on
        for n=1:16
            plot(xnew,signal{log}(n,:)) 
            pause(.01)
        end
    
        plot(xnew,avgsig{log},'r')
        pause(2)
    end
end

%% drift test

if drifttest
    driftmesh = [];
    for log=1:(numberoflogs)
        driftmesh(log,:) = abs(fft(decimate(datarmdc(log,:),32)));
    end
    mesh(driftmesh)
end
