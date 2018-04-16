%-----------------E1(VolF) ----------------%
 str = sprintf('E1_{ply}(VolF) \n Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [MPa] vf =%0.2f [-] \n Em=%0.2f [GPa] Gm =%0.2f [MPa] vm =%0.2f [-]', fiber.Ef1*1e-9, fiber.Ef2*1e-9, fiber.Gf*1e-9, fiber.vf, resin.Em*1e-9, resin.Gm*1e-9, resin.vm);
% srt_file = sprintf('FailureModes_stress(FibreVolumeFraction)');
srt_file = sprintf('E1_ply(VolF) Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [MPa] vf =%0.2f [-]  Em=%0.2f [GPa]  Gm =%0.2f [MPa] vm =%0.2f [-]', fiber.Ef1*1e-9, fiber.Ef2*1e-9, fiber.Gf*1e-9, fiber.vf, resin.Em*1e-9, resin.Gm*1e-9, resin.vm);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','E1(VolF)');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(VolF_step, [ply.E1] * 1e-9);
grid on;
xlabel('VolF [-] ');
ylabel('E1 [GPa]');
title(str);
legend('E1');

% cd('UniaxialLoadStiffness')
foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
% cd ..