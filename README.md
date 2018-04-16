# CLT
This repo contains matlab code for Classical Lamination Theory.

example script

```Matlab
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
```


output

```
composite = 

  Composite with properties:

                   plies: [1×15 Validation_ply]
                     ABD: [6×6 double]
         angles_of_plies: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    thicknesses_of_plies: [1×15 double]
                      Ex: 1.38e+11
                      Ey: 9e+09
                     Gxy: 6.9e+09
                coupling: 'coupling'
                     CTE: [6×1 double]


pipe = 

  Pipe with properties:

            r_inner: 0.025
                Imo: 0.0017234
                  w: [1347.6 4042.8 6738]
              w_rpm: [141.12 423.36 705.6]
               area: 0.00063323
                Iyy: 2.2979e-07
                 Io: 4.5958e-07
            r_outer: 0.02875
             length: 2.5
          composite: [1×1 Composite]
                rho: 1500
    total_thickness: 0.00375
                 Ef: 1.38e+11
                 Gt: 6.9e+09
```