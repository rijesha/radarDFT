
%Configures FMC111 parameters, once per fpga programming
% 
%setting LO frequency in kHz
%sets channel 1 r to 2000mHZ
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq RX AB 915000');

%setting rx gain, probably need to dynamically adjust as plane moves away
%towards
% sets gain to be 10dBi (4.5-20.25 dBi)
b4d_send_command('127.0.0.1','A','fmc111_set_vga_gain AB 4.5');

%setting use specific filter
% currently set for around wifi (2.45Ghz) x7=2.4-2.5Ghz
% therefore default is probably in place (x0?)
b4d_send_command('127.0.0.1','A','fmc111_set_ms_filt RX AB xA');


%setting attenuation, might be needed with vga gain to stabalize rx signal
%strenght, 2-31 0.5db steps.
b4d_send_command('127.0.0.1','A','fmc111_set_atten RX AB 2');

%setting Tx stuff
%sets the local oscilator frequency
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq TX AB 915000');

%set the ms filt for the TX
%b4d_send_command('127.0.0.1','A','fmc111_set_ms_filt TX AB xA');



%% Turn on tone
%set tonetest freq
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq TX AB 2430000')

%set tone gain
b4d_reg_write('127.0.0.1', 'A', 'qchannel', 0);
b4d_reg_write('127.0.0.1', 'A', 'ichannel', 10000); %10000 ~1.5dBm 19999 ~10dBm @2.4 GHz

%% Turn off tone
b4d_reg_write('127.0.0.1', 'A', 'ichannel', 0);