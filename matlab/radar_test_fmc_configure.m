function [  ] = radar_test_fmc_configure()
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
b4d_send_command('127.0.0.1','A','fmc111_set_ms_filt TX AB xA');

%set the antenuator for the Tx thing?
b4d_send_command('127.0.0.1','A','fmc111_set_atten TX AB 2');


%set tonetest freq
fc = .0005; %this line sets the tone frequency. It is in MHz

fs = 245.76; % MHz
nob = 24; % number of bits in the frequency control word
fcw = round(fc/fs*(2^nob))

b4d_reg_write('127.0.0.1', 'A', 'freq0', fcw);

%set tone gain
b4d_reg_write('127.0.0.1', 'A', 'tone_gain', hex2dec('400'));
end

