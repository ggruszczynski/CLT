%-----------------PoissonsRatio(angle) ----------------%
 str = sprintf('Poissons Ratio (angle) \n VolFib =%0.2f [-] \n Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [MPa] vf =%0.2f [-] \n Em=%0.2f [GPa] Gm =%0.2f [GPa] vm =%0.2f [-]',  materialdata.VolF, materialdata.Ef1*1e-9, materialdata.Ef2*1e-9,materialdata.Gf*1e-9, materialdata.vf, materialdata.Em*1e-9, materialdata.Gm*1e-9, materialdata.vm);
% srt_file = sprintf('FailureModes_stress(FibreVolumeFraction)');
srt_file = sprintf('vxy(angle)VolFib =%0.2f [-] Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [GPa] vf =%0.2f [-]  Em=%0.2f [GPa]  Gm =%0.2f [GPa] vm =%0.2f [-]',  materialdata.VolF, materialdata.Ef1*1e-9, materialdata.Ef2*1e-9, materialdata.Gf*1e-9, materialdata.vf, materialdata.Em*1e-9, materialdata.Gm*1e-9,materialdata.vm);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','PoissonsRatio');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(theta, vxy, theta, vyx);
grid on;
xlabel('angle [deg] ');
ylabel('Poissons Ratio [-]');
title(str);
legend('vxy','vyx');

cd('UniaxialLoadStiffness')
foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
cd ..