clc, clear %format long
% format shortG 

addpath(genpath('../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../SOLVER'));
addpath(genpath('../MEASURMENTS'));  % Call genpath inside of addpath to add all subfolders

%% calculate ply properties
% winding = Sample_Winding;
% fiber = T700S;
% resin = TGRADE_RED_COMP;
% ply = Ply(winding,fiber,resin)

%% or use ply with known properties
ply = Validation_ply();

% top-->bottom 
% theta = [30,90,-30]; 
% theta = [60,0,-60];
% theta = [60,0,30];
% theta = theta + 15
theta = [0,0,0,0,0,  0,0,0,0,0, 0,0,0,0,0, ];
% theta = [45,-45,-45,45];
% theta = theta + 90
  
plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, ply];
end

composite = Composite(plies, theta, 'coupling')
composite.ABD;
inv(composite.ABD);

%% PIPE DIMENSIONS
r_mold = 0.025; %[m]
length =  2.5; %[m] length
pipe = Pipe(composite,r_mold,length)
mass = length *pipe.area*pipe.rho; %[kg]

price_kg = 60; %[eur/kg]
price = mass*price_kg; %[eur]
    