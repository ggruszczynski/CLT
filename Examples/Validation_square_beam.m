clc, clear %format long
format shortG 

addpath(genpath('../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../SOLVER'));

% winding = Sample_Winding;
% fiber = T700SC;
% resin = TGRADE_RED_COMP;
% ply = Ply(winding,fiber,resin);


 valply = Validation_ply()
 valply.C12;
 
 [Cxy, Sxy] = valply.StiffnesXY(45);
 

% top-->bottom 
theta = [40,30];


plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, valply];
end

composite = Composite(plies, theta, 'zero_coupling')
composite.ABD;

% PIPE DIMENSIONS
    b_outer_kopyto = 0.035; %[m]
    h_outer_kopyto = 0.07; %[m]
    length =  2; %[m]
    square = RectBeam(composite,b_outer_kopyto, h_outer_kopyto, length);
	square
    
