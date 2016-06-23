%%

<<<<<<< HEAD
b4d_reg_write('127.0.0.1','A','capture', 1);%writeenable
b4d_reg_write('127.0.0.1','A','capture', 0);%writeenable
pause(1)

I10k=uint32castfix(b4d_bram_read('127.0.0.1','A','10kI',65536),1,16);
Q10k=uint32castfix(b4d_bram_read('127.0.0.1','A','10kQ',65536),1,16);

figure; subplot(2,2,1);
plot(I10k);
hold on; plot(Q10k,'r');


I100k=uint32castfix(b4d_bram_read('127.0.0.1','A','100kI',65536),1,16);
Q100k=uint32castfix(b4d_bram_read('127.0.0.1','A','100kQ',65536),1,16);
subplot(2,2,2); plot(I100k);
hold on; plot(Q100k,'r');


I5M=uint32castfix(b4d_bram_read('127.0.0.1','A','5MI',65536),1,16);
Q5M=uint32castfix(b4d_bram_read('127.0.0.1','A','5MQ',65536),1,16);
subplot(2,2,3); plot(I5M);
hold on; plot(Q5M,'r');


I250M=uint32castfix(b4d_bram_read('127.0.0.1','A','250MI',65536),1,16);
Q250M=uint32castfix(b4d_bram_read('127.0.0.1','A','250MQ',65536),1,16);
subplot(2,2,4); plot(I250M);
hold on; plot(Q250M,'r');


figure; plot(abs(fft(I250M)));
=======
%b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq RX AB 915800')
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq RX AB 3345800')
plottime = 1;
plotfft = 1;
advlog = 1;
timetolog = 5; %minutes
samplingrate = 10000; %Hz
bramsize = 65536;


timetofillbram = bramsize/10000;

figure;

if timetolog ~= 0
   numoflogs = fix(timetolog*60/timetofillbram);
   Idata = zeros(numoflogs,bramsize);
   Qdata = zeros(numoflogs,bramsize);
   
else
   numoflogs = 1;
   Idata = zeros(numoflogs,bramsize);
   Qdata = zeros(numoflogs,bramsize);
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

if advlog == 1

I250M=uint32castfix(b4d_bram_read('127.0.0.1','A','250MI',65536),1,18);
Q250M=uint32castfix(b4d_bram_read('127.0.0.1','A','250MQ',65536),1,18);

I5M=uint32castfix(b4d_bram_read('127.0.0.1','A','5MI',65536),1,18);
Q5M=uint32castfix(b4d_bram_read('127.0.0.1','A','5MQ',65536),1,18);

I100k=uint32castfix(b4d_bram_read('127.0.0.1','A','100kI',65536),1,18);
Q100k=uint32castfix(b4d_bram_read('127.0.0.1','A','100kQ',65536),1,18);

end


if plottime == 1
figure; subplot(2,2,1);
plot(I10k);

if advlog == 1

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

if advlog == 1
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
>>>>>>> 7b849df9430aa8a3762cc33b16508ac4ee70599d

%%
[Idatatmp, Qdatatmp] = bram_array_read_capture();
tmp = abs(fft(Idatatmp + i*Qdatatmp)); 
figure;
plot(20*log10(tmp(524288/2:524288)))
figure;
plot(Idatatmp)

figure;
plot((tmp(524288/2:524288)))
figure;
plot(xaxis,tmp)