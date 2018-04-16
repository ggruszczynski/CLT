%----------------- w = w(F, beam length) ----------------%
str = sprintf('w = w(F, beam length)');
srt_file = sprintf('w = w(F,beam_length)');
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','w = w(F,beam_length)');       
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
surf(beam_length, F, w, 'EdgeColor','none') % hide mesh edges
grid on;
colormap hsv
colorbar
shading interp % interpolate colors
xlabel('beam lenght [m]');
ylabel('force [N]');
zlabel('deflection [m]');
title(str);

foldername = 'FreeF_Point_plot3D';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
