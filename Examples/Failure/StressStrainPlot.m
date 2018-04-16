
%-----------------FailureModes: stress(strain) ----------------%
 str = sprintf('FailureModes: stress(strain)   \n FibreVolumeFraction=%0.2f [%%] \n SigFUlt =%0.2f [MPa] Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] \t SigMUlt =%0.2f [MPa]  Em=%0.2f [GPa]',winding.VolF*100,  fiber.SigFUlt_1t*1e-6 ,fiber.Ef1*1e-9, fiber.Ef2*1e-9, resin.SigMUlt_1t*1e-6, resin.Em*1e-9  );
srt_file = sprintf('stress(strain) Vf=%0.0f SigFUlt =%0.0f  Ef1=%0.0f Ef2=%0.0f SigMUlt =%0.0f  Em=%0.0f ',winding.VolF*100, fiber.SigFUlt_1t*1e-6 ,fiber.Ef1*1e-9, fiber.Ef2*1e-9, resin.SigMUlt_1t*1e-6, resin.Em*1e-9);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','FailureModes');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(EpsC, SigC*1e-6, EpsC,  SigF*1e-6, EpsC , SigM*1e-6 );
grid on;
xlabel('\epsilon [-] ');
ylabel('\sigma [MPa]');
title(str);
legend('\sigma_{Composite}','\sigma_{Fibers}','\sigma_{Matrix}');
xlim([0,0.01]); % Set the x-axis limit to match the range of data.
% % ylim([0,1000e6]); % Set the y-axis limit to match the range of data.

foldername = 'myplots';
% cd('FailureModes')
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
% cd ..