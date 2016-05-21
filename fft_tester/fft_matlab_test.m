clc;

%%
f = 300;
fs =1024;
T=1/fs;
n = 0:10000;
t=n*T;
x=sin(2*pi*f*t);

data = [n;x]';

%%

start = find(min(T_Valid.data));
N = 256;
delta_f = fs/N;

f = [0:N-1] * delta_f;

im = Data_im.data;
re = Data_re.data;
Mag = sqrt(im.^2 +re.^2);
plot([0:255],20*log10(Mag(9571:9826)))
