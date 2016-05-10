%Long sampling script for PCB Analysis

Idata = zeros(450,8*2^16);
Qdata = zeros(450,8*2^16);

tlength = 15; %time length in minutes
tlength = tlength*60;

index = 0;
t = 0;
tstart = cputime*10;
n = 1;

while ((cputime*10 - tstart)>tlength)
    [Idatatmp, Qdatatmp] = bram_array_read_capture();
    Idata(n) = Idatatmp;
    Qdata(n) = Qdatatmp;
    n=n+1;
    pause(2)
end
