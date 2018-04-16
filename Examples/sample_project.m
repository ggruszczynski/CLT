clc, clear %format long
% format shortG 


addpath(genpath('../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../SOLVER'));
addpath(genpath('../MEASURMENTS'));  % Call genpath inside of addpath to add all subfolders

% winding = Sample_Winding;
% fiber = T700S;
% resin = TGRADE_RED_COMP;
% ply = Ply(winding,fiber,resin)

valply = Validation_ply();

% top-->bottom 
% theta = [30,90,-30]; 
% theta = [60,0,-60];
% theta = [60,0,30];
% theta = theta + 15
% theta = [7,-7,-7,7];
theta = [0,0,0,0,0,  0,0,0,0,0, 0,0,0,0,0, ];
% theta = [45,-45,-45,45];
%    theta = theta + 90
  
plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, valply];
end

composite = Composite(plies, theta, 'coupling')
composite.ABD;
inv(composite.ABD);

%% PIPE DIMENSIONS
r_mold = 0.025; %[m]
length =  2.5; %[m] length
pipe = Pipe(composite,r_mold,length)
mass = length *pipe.area*pipe.rho %[kg]

price_kg = 200; %[pln/kg]
price = mass*price_kg %[pln]
    
% %% deflection
%      Force = 10; %[N]
%      FreeF_Point( pipe.Ef , pipe.Iyy, Force, pipe.length );
%      
%      rurka.FSigX_Pure_Bending(10)

% %% Freq MEASURMENT    
% %     E_expected = 200e9; %[Pa]  
%      E_expected = rurka.Ef; %[Pa]  
% % %     pipe.rho = 7850;  %[kg/m3]
%     
%     f_measured = [  1.50E+002	3.93E+002 0 ]; % [Hz] FEA
%      
% 
% % E_expected = rurka.Ef;
%     pomiarek = E_Measurment(rurka, E_expected, f_measured)

% %% ERRORS
%     bledzik = E_errors_pipe(pipe, pomiarek);
% 
% %     bledzik = E_errors_custom(belka, pomiarek);
% %     bledzik
%     bledzik.show_results(pomiarek)