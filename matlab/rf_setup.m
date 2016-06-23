%MS filter codes
% 2.4-2.5 GHz    7     x7
% 0.8-3.0 GHz    10    xA
% 3.1-4.9 GHz    11    xB

%% Turn on tone
%
b4d_send_command('127.0.0.1','A','fmc111_set_ms_filt TX AB xA');

%set tonetest freq
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq TX AB 915000')

%set tone gain
b4d_reg_write('127.0.0.1', 'A', 'qchannel', 0);
b4d_reg_write('127.0.0.1', 'A', 'ichannel', 10000); %10000 ~1.5dBm 19999 ~10dBm @2.4 GHz

%% Turn off tone
b4d_reg_write('127.0.0.1', 'A', 'ichannel', 0);

% set filter outside of freq
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq TX AB 2430000')
b4d_send_command('127.0.0.1','A','fmc111_set_ms_filt TX AB x4'); 

%% Setting up receiver

%change LO freq
b4d_send_command('127.0.0.1','A','fmc111_set_lo_freq RX AB 915000')

%change receiver bandpass filter
b4d_send_command('127.0.0.1','A','fmc111_set_ms_filt RX AB xA');

%set attenuation if necessary max 31.5
b4d_send_command('127.0.0.1','A','fmc111_set_atten RX AB 2.5');

%set gain if necessary min 4.5 max 20.25
b4d_send_command('127.0.0.1','A','fmc111_set_vga_gain AB 10');

