classdef TGRADE_RED_COMP < Resin
   % T-GRADE RED COMP: Resin Material Preperties
    properties (SetAccess = protected)      
        Em = 3.1e9;    %Young's Modulus of Matrix [Pa]        
        vm = 0.35; %GUESS%     %Poisson's Ratio of Matrix  
         Gm 
%         Gm = Em/(2*(1+vm)); % assuming vm
%         Gm =  1.27e9; %GUESS%  %Shear Modulus of Matrix [Pa] 
        
        
        SigMUlt_1t = 0e6; %Ultimate strenght of the matrix [Pa]

        alfa_m = 200e-6; % CTE of Matrix [1/K]
        rhom = 1196;     % density of Matrix [kg/m3]
    end
    
    methods
        function this = TGRADE_RED_COMP(~)
%             this.Gm =  1.27e9; %GUESS%  %Shear Modulus of Matrix [Pa] 
            this.Gm = this.Em/(2*(1+this.vm)); % assuming vm
        end
        
    end
    
end

