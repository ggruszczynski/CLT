%----------------------------------- Plot Lambda --------------------------------------%

str_title = sprintf('numLambda');
srt_file = sprintf('numLambda');
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','numLambda');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(range, charPol(range))
grid on;
xlabel('range')
ylabel('numLambda')
title(str_title);
legend('numLambda');

foldername = 'my_plots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..