clc, clear
format shortG
addpath(genpath('../SOLVER'));
addpath(genpath('G_FreqMeasurments'));  % Call genpath inside of addpath to add all subfolders
%% PIPE DIMENSIONS
    
%% GEOMETRY

% PIPE DIMENSIONS
    r_mold = 0.035; %[m]

    pipe = Pipe;

    pipe.length =  2; %[m] length
    pipe.r_inner = r_mold; % [m] inner radius
    pipe.rho = 7800;%[kg/m3] material density
    pipe.Ef = 210e9; % [Pa]
    pipe.Gt = 70e9; % [Pa]
    pipe.total_thickness = 0.00175; %[m]
    
    pipe.Imo = pipe.CalcImo();
    pipe.w = pipe.Calcw();
    pipe.w_rpm = 2*pi*pipe.w/60;
    
    pipe


        
%% MEASURMENT    
    distance = 1; % [m] - distance from the axis of rotation to the additional inertia unit
    imo_additional = Imo_additional(4)

     T  = 3; %[s] period with additional, movable inertia units
     T0 = 2; %[s] period without additional, movable inertia units
    
    measurment = G_FreqMeasurment(pipe, imo_additional, T, T0)