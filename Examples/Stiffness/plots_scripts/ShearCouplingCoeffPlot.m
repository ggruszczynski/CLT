%-----------------ShearCoupplingCoefficients(angle) ----------------%
 str = sprintf('ShearCoupplingCoefficients (angle) \n  nxxy - stress state is defined as SigX ~= 0 and SigY = SigXY = 0 \n nxyx - stress state is defined as SigXY ~= 0 and SigX = SigY = 0 \n \n VolFib =%0.2f [-] \n Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [GPa] vf =%0.2f [-] \n Em=%0.2f [GPa] Gm =%0.2f [GPa] vm =%0.2f [-]',  materialdata.VolF, materialdata.Ef1*1e-9, materialdata.Ef2*1e-9,materialdata.Gf*1e-9,materialdata.vf, materialdata.Em*1e-9, materialdata.Gm*1e-9,materialdata.vm);
% srt_file = sprintf('FailureModes_stress(FibreVolumeFraction)');
srt_file = sprintf('nxy(angle) VolFib =%0.2f [-] Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [GPa] vf =%0.2f [-]  Em=%0.2f [GPa]  Gm =%0.2f [GPa] vm =%0.2f [-]',  materialdata.VolF, materialdata.Ef1*1e-9, materialdata.Ef2*1e-9,materialdata.Gf*1e-9,materialdata.vf, materialdata.Em*1e-9, materialdata.Gm*1e-9,materialdata.vm);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','PoissonsRatio');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(theta, nxxy, theta, nxyx);
grid on;
xlabel('angle [deg] ');
ylabel('shear-coupling coefficients [-]');
title(str);
legend('\eta_{x,xy} = \gamma_{xy} / \epsilon_{x}','\eta_{xy,x} = \epsilon_{x} / \gamma_{xy}');

cd('UniaxialLoadStiffness')
foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
cd ..