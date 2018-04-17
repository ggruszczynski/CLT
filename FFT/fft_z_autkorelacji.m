clc, clear

%% import data
% Unfortunately Audacity names all (despite its contents) exported .txt files as 'spectrum.txt' 

delimiterIn = '\t';
headerlinesIn = 1;

dirName = pwd; %# folder path = print working directory
fnames = dir( fullfile(dirName,'*.txt') );     %# list all *.xyz files
fnames = {fnames.name}';                       %'# file names

mydata = cell(numel(fnames),1);                %# store file contents
for i=1:numel(fnames)
    fpath = fullfile(dirName,fnames{i});       %# full path to file
    mydata{i} = importdata(fpath,delimiterIn,headerlinesIn);        %# load file
end


for i = 1: numel(mydata);
    Lagseconds = mydata(i);
    Lagseconds = Lagseconds{1};
    Lagseconds = Lagseconds.data(:,1);
    
    Level = mydata(i);
    Level = Level{1};
    Level = Level.data(:,3);
    
    T = Lagseconds(2)-Lagseconds(1);          % Sample time
    Fs = 1/T;                                 % Sampling frequency
    L = size(Lagseconds);                     % Length of signal
    L(:,2)=[];

    %% FFT from Autocorrelation
    NFFT= 1* 2^nextpow2(L); % Transform length Next power of 2 from length of y --> rectangular window?
%     NFFT = 2^16; % rozmiar fft [pr] - zero padding? po co?

    win = hamming(L); %hamming window
    windowed_signal = Level;% .* win;   

    Y = fft(windowed_signal,NFFT)/L;
%     Y = fft2(windowed_signal)/L;
%     Y = fftshift(fft(windowed_signal,NFFT)/L); % [pr]
%     Y = fftshift(fft(ifftshift(windowed_signal,NFFT)))/L; % [dla  NFFT= L]
    
    f = Fs/2*linspace(0,1,NFFT/2+1);  
%     f = Fs/2*(-1:2/NFFT:1-2/NFFT); % [pr]

    %% make plots
    plots;

end