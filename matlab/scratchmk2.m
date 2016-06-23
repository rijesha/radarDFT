%% scratch mk2

%b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq RX AB 915800')
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq RX AB 3345800')
plottime = 1; %set to 1 to plot time domain
plotfft = 1; %set to 1 to plot fft
advlog = 1; % log data higher than 10kHz
advplot = 1; % plot data higher than 10kHz
timetolog = 5; %minutes set to 0 to ensure signal is in range
samplingrate = 10000; %Hz
bramsize = 65536;


timetofillbram = bramsize/10000;

figure;

if timetolog ~= 0
   numoflogs = fix(timetolog*60/timetofillbram);   
else
   numoflogs = 1;
end

Idata = zeros(numoflogs,bramsize);
Qdata = zeros(numoflogs,bramsize);
if advlog == 1
    Idata100k = zeros(numoflogs,bramsize);
    Qdata100k = zeros(numoflogs,bramsize);
    Idata5M= zeros(numoflogs,bramsize);
    Qdata5M = zeros(numoflogs,bramsize);
    Idata250M = zeros(numoflogs,bramsize);
    Qdata250M = zeros(numoflogs,bramsize);
end

for ind = 1:numoflogs

b4d_reg_write('127.0.0.1','A','capture', 1);%writeenable
b4d_reg_write('127.0.0.1','A','capture', 0);%writeenable
pause(timetofillbram);




I10k = uint32castfix(b4d_bram_read('127.0.0.1','A','10kI',65536),1,18);
Q10k = uint32castfix(b4d_bram_read('127.0.0.1','A','10kQ',65536),1,18);
Idata(ind,:) = I10k;
Qdata(ind,:) = Q10k;

half = 65536/2;
I10kfft = abs(fft(I10k));
plot(I10kfft(half + 1 :end));


fprintf('log number: %d \n',ind)
fprintf('elapse time (min) : %d \n',ind*timetofillbram/60)

end

if (advlog == 1 || advplot == 1)

I250M=uint32castfix(b4d_bram_read('127.0.0.1','A','250MI',65536),1,18);
Q250M=uint32castfix(b4d_bram_read('127.0.0.1','A','250MQ',65536),1,18);


I5M=uint32castfix(b4d_bram_read('127.0.0.1','A','5MI',65536),1,18);
Q5M=uint32castfix(b4d_bram_read('127.0.0.1','A','5MQ',65536),1,18);


I100k=uint32castfix(b4d_bram_read('127.0.0.1','A','100kI',65536),1,18);
Q100k=uint32castfix(b4d_bram_read('127.0.0.1','A','100kQ',65536),1,18);


if advlog == 1
Idata250M(ind,:) = I250M;
Qdata250M(ind,:) = Q250M;
Idata5M(ind,:) = I5M;
Qdata5M(ind,:) = Q5M;
Idata100k(ind,:) = I100k;
Qdata100k(ind,:) = Q100k;
end

end


if plottime == 1
figure; subplot(2,2,1);
plot(I10k);

if advplot == 1
hold on; plot(Q10k,'r');
subplot(2,2,2); plot(I100k);
hold on; plot(Q100k,'r');
subplot(2,2,3); plot(I5M);
hold on; plot(Q5M,'r');
subplot(2,2,4); plot(I250M);
hold on; plot(Q250M,'r');
end
end

if plotfft == 1
half = 65536/2;
figure; subplot(2,2,1);
I10kfft = abs(fft(I10k));
plot(I10kfft(half + 1 :end));

if advplot == 1
subplot(2,2,2);
I100kfft = abs(fft(I100k));
plot(I100kfft(half + 1 :end));
subplot(2,2,3);
I5Mfft = abs(fft(I5M));
plot(I5Mfft(half + 1 :end));
subplot(2,2,4);
I250Mfft = abs(fft(I250M));
plot(I250Mfft(half + 1 :end));
end
end
