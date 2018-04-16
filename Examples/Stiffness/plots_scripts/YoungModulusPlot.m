%-----------------YoungModulus(angle) ----------------%
 str = sprintf('Modulus of elesticity (angle) \n VolFib =%0.2f [-] \n Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [MPa] vf =%0.2f [-] \n Em=%0.2f [GPa] Gm =%0.2f [MPa] vm =%0.2f [-]',  winding.VolF, fiber.Ef1*1e-9, fiber.Ef2*1e-9, fiber.Gf*1e-9, fiber.vf, resin.Em*1e-9, resin.Gm*1e-9, resin.vm);
% srt_file = sprintf('FailureModes_stress(FibreVolumeFraction)');
srt_file = sprintf('E(angle)VolFib =%0.2f [-] Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [MPa] vf =%0.2f [-]  Em=%0.2f [GPa]  Gm =%0.2f [MPa] vm =%0.2f [-]',  winding.VolF, fiber.Ef1*1e-9, fiber.Ef2*1e-9, fiber.Gf*1e-9, fiber.vf, resin.Em*1e-9, resin.Gm*1e-9, resin.vm);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','YoungModulus');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(theta_step, Ef*1e-9,theta_step, Ex*1e-9);
grid on;
xlabel('angle [deg] ');
ylabel('Youngs modulus [MPa]');
title(str);
legend('Ef','Ex');

% cd('UniaxialLoadStiffness')
foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
% cd ..