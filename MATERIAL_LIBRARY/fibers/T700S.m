classdef T700S < Fiber
    % T700S: Fiber Material Preperties
    
    properties (SetAccess = protected)
        Ef1 = 230e9;   %Young's Modulus of Fibers [Pa] - Longitudinal
        Ef2 = 230e9;   %Young's Modulus of Fibers [Pa] - Transverse
        Gf   %Shear Modulus of Fibers [Pa]
        vf = 0.25; %Poisson's Ratio of Fibers
        SigFUlt_1t = 4.9e9;%Longitudinal tensile strength [Pa]
        
        alfa_f1=  -0.38e-6; %CTE of Fibers [1/K] - Longitudinal
        alfa_f2=  -0.38e-6; %CTE of Fibers [1/K] - Transverse
        rhof = 1800; % density of Fibers [kg/m3]
    end
    
    methods
        function this = T700S(~)
            %what about Longitudinal and  Transverse Poisson's Ratio of
            %Fibers (and corresponding Shear Modulus)???
%           this.Gm =  15e9; %GUESS%  %Shear Modulus of Fibers [Pa] 
            this.Gf = this.Ef1/(2*(1+this.vf)); % assuming vf
        end
        
    end
    
end

