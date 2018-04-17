%----------------------------------- Plot Autocorrelation --------------------------------------%
% str_title = strcat(sprintf('Autocorrelation'),'\_',fnames{i}); % add strings
% srt_file = strcat(sprintf('Autocorrelation'),'_',fnames{i});
% srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
% figure ('name','Autocorrelation');
% set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
% plot(Lagseconds, Level)
% grid on;
% xlabel('time (s)')
% ylabel('Level')
% title(str_title);
% legend('Level');

% % foldername = 'my_plots';
% % if ~exist(foldername,'dir')
% %     mkdir(foldername)
% % end
% % cd(foldername)
% print('-djpeg','-r300',srt_file);
% % cd ..


%-------------------------- Plot single-sided amplitude spectrum -----------------------------------%
%-----------------FFT from Autocorrelation: Single-Sided Amplitude Spectrum of y(t) ----------------%
str_title = strcat(sprintf('FFT from Autocorrelation: Single-Sided Amplitude Spectrum of y(t)'),'\_',fnames{i});
srt_file = strcat(sprintf('FFT from Autocorrelation'),'_',fnames{i});
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','FFT from Autocorrelation');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
% semilogx(f,2*abs(Y(1:NFFT/2+1))) 
plot(f,2*abs(Y(1:NFFT/2+1)) );
% plot(f(f>=0),2*abs(Y(f>=0))) % [pr]
grid on;
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
title(str_title);
legend('|Y(f)|');
xlim([0,2000]); % [Hz] Set the x-axis limit to match the range of data.
% ylim([0,600e6]); % Set the y-axis limit to match the range of data.


% foldername = 'my_plots';
% if ~exist(foldername,'dir')
%     mkdir(foldername)
% end
% cd(foldername)
print('-djpeg','-r300',srt_file);
% cd ..
