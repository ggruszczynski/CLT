clc, clear, 
format shortG 

addpath(genpath('../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../SOLVER'));
addpath(genpath('../MEASURMENTS'));  % Call genpath inside of addpath to add all subfolders

valply = Validation_ply();

% top-->bottom 
theta = [ -45,45, -45, 45]; 
plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, valply];
end


kompozyt = Composite(plies, theta, 'coupling');
dTemp = 80; % dTemp  - temperature change [K]

[MidplaneThermalStrains, Nt_composite, Mt_composite] = kompozyt.ThermalLoads(dTemp)

kompozyt.CTE

