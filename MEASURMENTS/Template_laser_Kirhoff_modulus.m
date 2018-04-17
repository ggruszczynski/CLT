clc, clear %format long
format shortG 

% Call genpath inside of addpath to add all subfolders
addpath(genpath('../MATERIAL_LIBRARY'));
addpath(genpath('../SOLVER'));
addpath(genpath('G_LaserMeasurments')); 

winding = Sample_Winding;
fiber = T700SC;
resin = TGRADE_RED_COMP;
warstwa = Ply(winding,fiber,resin);
 
% theta = [45,-45,-45,45,-45,45,-45];
theta = [7,-7,7,-7,7,-7,7,-7];

warstwy=[];
for i=1:numel(theta)% all plies from the same material
    warstwy = [warstwy, warstwa];
end

kompozyt = Composite(warstwy, theta, 'zero_coupling')


%% PIPE DIMENSIONS
    r_kopyto = 0.035; %[m]
    length =  2; %[m] length
    rurka = Pipe(kompozyt,r_kopyto,length);

	rurka
   
%% TWISTING  
    F = 50; %[N]
    x = 1; %[m]
    L = 2; %[m] distance between mirrors
    S = 3; %[m] distance from mirror to laser
    deltaH = 0.145; %[m] deltaH = H2 - H1  difference in heights of the reflected laser pointers after applying the moment
    pomiarek = G_LaserMeasurment(rurka, F,x, L, S, deltaH);
    
%% ERRORS
bledzik = G_LM_Errors_pipe(rurka, pomiarek);
bledzik.show_results(pomiarek);




