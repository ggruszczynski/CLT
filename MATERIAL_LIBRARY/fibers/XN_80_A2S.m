classdef XN_80_A2S < Fiber
    % XN_80_A2S: Fiber Material Preperties
    
    properties (SetAccess = protected)
        Ef1 = 780e9;   %Young's Modulus of Fibers [Pa] - Longitudinal
        Ef2 = 780e9;   %Young's Modulus of Fibers [Pa] - Transverse
        Gf = 15e9;   %Shear Modulus of Fibers [Pa]
        vf = 0.25; %Poisson's Ratio of Fibers
        SigFUlt_1 = []; %Longitudinal tensile strength [Pa]

        alfa_f1=  -1.5e-6; %CTE of Fibers [1/K] - Longitudinal
        alfa_f2=  -1.5e-6; %CTE of Fibers [1/K] - Transverse
        rhof = 2170; % density of Fibers [kg/m3]
    end
    
    methods
    end
    
end