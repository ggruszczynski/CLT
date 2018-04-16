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
theta = [45,90];


plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, valply];
end

composite = Composite(plies, theta, 'zero_coupling')
composite.ABD;

% PIPE DIMENSIONS
    b_outer_mold = 0.035; %[m]
    h_outer_mold = 0.07; %[m]
    r_outer_mold = 0.01; %[m]
    length =  2; %[m]
    rectFilletBeam = RectFilletBeam(composite,r_outer_mold, b_outer_mold, h_outer_mold, length);
	rectFilletBeam
    
% kwadrat_fillet.CalcIyyPly(4,3,2,1)
%%     
% fprintf('rurka.Iyy*composite.Ex = %0.2f [N*m2] \n', rurka.Iyy*composite.Ex);
% fprintf('rurka.Iyy*rurka.Ef = %0.2f [N*m2] \n',  rurka.Iyy*rurka.Ef);   

% fprintf('\nrurka.Io*composite.Gxy = %0.2f [N*m2] \n', rurka.Io*composite.Gxy);
% fprintf('rurka.Io*rurka.Gt = %0.2f [N*m2] \n',  rurka.Io*rurka.Gt);
