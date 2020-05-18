% Maximum likelihood sequence estimation using the Viterbi algorithm
% References: See Section 5.2 in the book "Digital Communications and
% Signal Processing" by K Vasudevan
% BPSK modulation, channel impairments: ISI (3 tap) and AWGN
% Note that this code works for a 3 tap channel only, if you wish to increase
% the number of channel taps, then you need to do minor changes in the code
clear all
close all
clc
data_len = 10^4; % length of the data sequence
SNR_dB = 20; % SNR per bit (in dB)
chan_len = 3; % number of channel taps ( DO NOT CHANGE THIS PARAMETER)
fade_var = 1; % fade variance of the channel
decoding_delay = 10; % decoding delay of the Viterbi algorithm
% SNR parameters
SNR = 10^(0.1*SNR_dB);
noise_var = 1*(fade_var*chan_len)/(2*SNR);

% source
a = randi([0 1],1,data_len);

% bpsk mapping
bpsk_seq = 1-2*a;

% impulse response of the ISI channel
fade_chan = normrnd(0,sqrt(fade_var),1,chan_len);

% awgn
noise = normrnd(0,sqrt(noise_var),1,data_len+chan_len-1);

% channel output
chan_op = conv(fade_chan,bpsk_seq)+noise;

% ------------------ RECEIVER----------------------------------------------
% steady state part of the received sequence
steady_state = chan_op(chan_len:data_len);

% branch metrics for the Viterbi algorithm
branch_metric = zeros(2^chan_len,data_len-chan_len+1);

branch_metric(1,:) = (steady_state-(fade_chan(1)+fade_chan(2)+fade_chan(3))).^2;
branch_metric(2,:) = (steady_state-(fade_chan(1)+fade_chan(2)-fade_chan(3))).^2;
branch_metric(3,:) = (steady_state-(fade_chan(1)-fade_chan(2)+fade_chan(3))).^2;
branch_metric(4,:) = (steady_state-(fade_chan(1)-fade_chan(2)-fade_chan(3))).^2;

branch_metric(5,:) = (steady_state-(-fade_chan(1)+fade_chan(2)+fade_chan(3))).^2;
branch_metric(6,:) = (steady_state-(-fade_chan(1)+fade_chan(2)-fade_chan(3))).^2;
branch_metric(7,:) = (steady_state-(-fade_chan(1)-fade_chan(2)+fade_chan(3))).^2;
branch_metric(8,:) = (steady_state-(-fade_chan(1)-fade_chan(2)-fade_chan(3))).^2;

%-----------------------------------------------------------------------------------
% Viterbi algorithm
dec_a=Viterbi_algorithm(data_len-chan_len+1,decoding_delay,branch_metric);

% bit error rate (ignoring transient parts)
ber = nnz(a(chan_len:data_len-decoding_delay)-dec_a )/(data_len-chan_len+1-decoding_delay)