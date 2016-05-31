clc;

%%
set_param('prelim_FFT_blockFP/numofsamples','value','2^8')
f = 300;
fs =1024;
T=1/fs;
n = 0:2^16*8*2;
t=n*T;
x=8192*sin(2*pi*f*t);

data = [n;x]';

%%

start = find(min(T_Valid.data));
N = 256;
delta_f = fs/N;

f = [0:N-1] * delta_f;

im = Data_im.data;
re = Data_re.data;
Mag = sqrt(im.^2 +re.^2);
figure;
plot([0:255],Mag(9571:9826))


%%
 %alternate plot
 
plot(Data_ind.data,re)
 %%
 plot(hanningout.Data)
 
 %%
 %scaleddb
 
 dbscale = 10000;
 plot([0:255],20*dbscale*log10(Mag(9571:9826)))
 