%%%%%%%%%%%%%%%%%% FailureCriteria: PlyFailure(Uniaxial stress, angle) -  %%%%%%%%%%%%%%%%%%%%%%%%
clc, clear %format long
format shortG 

addpath(genpath('../../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../../SOLVER'));

%% define ply
winding = Sample_Winding;
fiber = Validation_fibers;
resin = Validation_resin;
ply = Ply(winding,fiber,resin);
%  ply = Validation_ply();

%%

% StressUlt = ply.StressUlt; 
StressUlt = [1000e6, 200e6, 100e6]; % [Pa] Ultimate strenght [  Sig1,  Sig2,  Sig12]  in the fiber-oriented coord sys  


theta  = 0:0.1:90; % [deg] 
roz = size(theta);
roz(:,1)=[];
SigAppMaxTHU(roz) = 0;
StressUltXY(3,roz) = zeros;
StressUltCllipping = 1200e6; % [Pa] - plot clipping value

for i = 1: 1 : roz
    StressUltXY(1,i) =  StressUlt(1)/(cosd(theta(i))^2);
    StressUltXY(2,i) =  StressUlt(2)/(sind(theta(i))^2);
    StressUltXY(3,i) =  2*StressUlt(3)/sind(2*theta(i));

    if StressUltXY(1,i) > StressUltCllipping 
        StressUltXY(1,i) = StressUltCllipping;
    end 
    if StressUltXY(2,i) > StressUltCllipping 
        StressUltXY(2,i) = StressUltCllipping;
    end 
    if StressUltXY(3,i) > StressUltCllipping 
        StressUltXY(3,i) = StressUltCllipping;
    end 
    
    SigAppMaxTHU(i)  = TsaiHillUniaxial( StressUlt, theta(i) ); 
    if SigAppMaxTHU(i) > StressUltCllipping 
        SigAppMaxTHU(i)  = StressUltCllipping;
    end
end

FailureCriteriaPlot;

