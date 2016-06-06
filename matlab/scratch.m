%%

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