clc,clear
%%%%%%%%%%%%%%%%%% FailureModes: matrix vs fibers:  who fails first %%%%%%%%%%%%%%%%%%%%%%%%%%
% The load is applied along the direction of the fibres


clc, clear %format long
format shortG 

addpath(genpath('../../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../../SOLVER'));

%% define ply
winding = Sample_Winding;
fiber = Validation_fibers; %T700SC;
resin = Validation_resin; %TGRADE_RED_COMP;
% ply = Ply(winding,fiber,resin);

%%
EpsC = 0:0.00001:0.05;      % range of strains of the composite --> for analysis
% EpsC = 0:0.01:0.05
[SigC, SigF, SigM] =  LongitudinalStrength_Tension  (winding.VolF, EpsC, fiber.Ef1, fiber.SigFUlt_1t, resin.Em, resin.SigMUlt_1t);
StressStrainPlot; % for given volume fraction


VolF =0:0.01:0.5; % Volume Fraction of FIBERS [%]
roz = size(VolF);
roz(:,1)=[];
SigCMax(roz) = 0;

for i = 1: 1 : roz  
    [SigC, ~,  ~] =  LongitudinalStrength_Tension  (VolF(i), EpsC, fiber.Ef1, fiber.SigFUlt_1t, resin.Em, resin.SigMUlt_1t);
    SigCMax(i)=max(SigC);
end

 StressVfPlot;
