
%-----------------FailureModes: stress(fibre_volume_fraction) ----------------%
 str = sprintf('FailureModes: stress(fibre volume fraction) \n SigFUlt =%0.2f [MPa] Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] \n SigMUlt =%0.2f [MPa]  Em=%0.2f [GPa]', fiber.SigFUlt_1t*1e-6 ,fiber.Ef1*1e-9, fiber.Ef2*1e-9, resin.SigMUlt_1t*1e-6, resin.Em*1e-9 );
% srt_file = sprintf('FailureModes_stress(FibreVolumeFraction)');
srt_file = sprintf('stress(Vf)  SigFUlt =%0.0f  Ef1=%0.0f Ef2=%0.0f SigMUlt =%0.0f  Em=%0.0f ', fiber.SigFUlt_1t*1e-6 ,fiber.Ef1*1e-9, fiber.Ef2*1e-9, resin.SigMUlt_1t*1e-6, resin.Em*1e-9);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','FailureModes');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(VolF*100, SigCMax*1e-6);
grid on;
xlabel(' Fibre Volume Fraction [%] ');
ylabel('\sigma_{compositeMax} [MPa]');
title(str);
legend('\sigma_{CompositeMax}');

% cd('FailureModes')
foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
% cd ..

