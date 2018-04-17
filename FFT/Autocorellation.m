clc, clear

addpath('acf');
filename = 'probka_nagrania.wav';

[Level,Fs] = audioread(filename); % reads data from the file named filename, and returns sampled data, y, and a sample rate for that data, Fs
sound(Level,Fs); %Play the audio.
  

    %% FFT from pure signal
    Length_pure = numel(Level);                     % Length of the pure signal
    NFFT_pure= 1* 2^nextpow2(Length_pure); % Transform length Next power of 2 from length of y --> rectangular window?

        win = hamming(Length_pure); %hamming window
        windowed_signal = Level;% .* win;   
    Y_pure = fft(windowed_signal,NFFT_pure)/Length_pure;
    f_pure = Fs/2*linspace(0,1,NFFT_pure/2+1);  


    %% FFT from autocorellation    
    lags = 10000; % max in Audacity 65536

    tic
        Level_autocorel = acf(Level, lags); 
    toc
    
    Length_autocorel = numel(Level_autocorel); % Length of the autocorellated signal
    NFFT_autocorel= 1* 2^nextpow2(Length_autocorel); % Transform length Next power of 2 from length of y --> rectangular window?

        win = hamming(Length_autocorel); %hamming window
        windowed_signal = Level;% .* win;   
    Y_autocorel = fft(windowed_signal,NFFT_autocorel)/Level_autocorel;   
    f_autocorel = Fs/2*linspace(0,1,NFFT_autocorel/2+1);  


    %% make plots
    autocor_plots;
    