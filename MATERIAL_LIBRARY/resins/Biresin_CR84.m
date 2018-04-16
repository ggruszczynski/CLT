classdef Biresin_CR84 < Resin
   % Biresin_CR84 Sika: Resin Material Preperties
   % approx. values after 8 h / 70°C (source: Sika internal)
    properties (SetAccess = protected)      
        Em = 3.25e9;   %Young's Modulus of Matrix [Pa]
         Gm 
%         Gm = Em/(2*(1+vm)); % assuming vm
        
        vm = 0.35;     %Poisson's Ratio of Matrix  
        SigMUlt_1t = 0e6; %Ultimate strenght of the matrix [Pa]

        alfa_m = 0; % CTE of Matrix [1/K]
        rhom = 1150;     % density of Matrix [kg/m3]
    end
    
    methods
           function this = Biresin_CR84(~)
%             this.Gm =  1.2037e+09; %GUESS%  %Shear Modulus of Matrix [Pa] 
            this.Gm = this.Em/(2*(1+this.vm)); % assuming vm
        end
    end
    
end

