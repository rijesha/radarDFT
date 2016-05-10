function [I, Q ] = bram_array_read_capture(  )
%Capture the data from Bram blocks
b4d_reg_write('127.0.0.1','A','capture', 1);%writeenable
b4d_reg_write('127.0.0.1','A','capture', 0);%writeenable


Q0=uint32castfix(b4d_bram_read('127.0.0.1','A','Q0',65536),1,0);
Q1=uint32castfix(b4d_bram_read('127.0.0.1','A','Q1',65536),1,0);
Q2=uint32castfix(b4d_bram_read('127.0.0.1','A','Q2',65536),1,0);
Q3=uint32castfix(b4d_bram_read('127.0.0.1','A','Q3',65536),1,0);
Q4=uint32castfix(b4d_bram_read('127.0.0.1','A','Q4',65536),1,0);
Q5=uint32castfix(b4d_bram_read('127.0.0.1','A','Q5',65536),1,0);
Q6=uint32castfix(b4d_bram_read('127.0.0.1','A','Q6',65536),1,0);
Q7=uint32castfix(b4d_bram_read('127.0.0.1','A','Q7',65536),1,0);

I0=uint32castfix(b4d_bram_read('127.0.0.1','A','I0',65536),1,0);
I1=uint32castfix(b4d_bram_read('127.0.0.1','A','I1',65536),1,0);
I2=uint32castfix(b4d_bram_read('127.0.0.1','A','I2',65536),1,0);
I3=uint32castfix(b4d_bram_read('127.0.0.1','A','I3',65536),1,0);
I4=uint32castfix(b4d_bram_read('127.0.0.1','A','I4',65536),1,0);
I5=uint32castfix(b4d_bram_read('127.0.0.1','A','I5',65536),1,0);
I6=uint32castfix(b4d_bram_read('127.0.0.1','A','I6',65536),1,0);
I7=uint32castfix(b4d_bram_read('127.0.0.1','A','I7',65536),1,0);

Q = [Q0 Q1 Q2 Q3 Q4 Q5 Q6 Q7];
Q=Q-mean(Q);

I = [I0 I1 I2 I3 I4 I5 I6 I7];
I=I-mean(I);

end

