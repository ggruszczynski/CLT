classdef E_Measurment <  hgsetget
    %MEASURMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties  (SetAccess = private) % only the defining class can set property values. You can change the value of an object property only if the class defines a method to perform this action.
        beam = Pipe;
        
        E_expected ; % [Pa] expected Young's modulus
        f_expected; % [Hz]
        
        f_measured; % [Hz]
        E_measured; %[Pa]    
  
    end
    
    properties (Constant)
        name ='[-] free-free eigenvalues';
        lambda = [ 4.73004 7.85320 10.9956   ]; %[-] free-free eigenvalues (mode shape)
        %lambda = [1.875 4.694 7.855]; %[-] fixed-free eigenvalues (mode shape)        
        %lambda = [3.9243 7.0711 10.198 ]; %[-] hinge-free eigenvalues (mode shape)
    end
    
    methods       
        function this = E_Measurment(set_beam,set_E, set_f_measured)
            this.beam = set_beam;
            this.E_expected = set_E; 
            this.f_measured = set_f_measured;
            
            this.f_expected = CalcF_expected(this);
            this.E_measured = CalcE_measured(this);
        end
        
        function f_expected =  CalcF_expected(this)  
            f_expected = (this.lambda.^2) /(2*pi*this.beam.length^2) * sqrt(this.E_expected*this.beam.Iyy/(this.beam.rho*this.beam.area));
        end
        
        function E_measured =  CalcE_measured(this)  
            E_measured= this.beam.rho*this.beam.area/this.beam.Iyy *(2*pi*this.beam.length^2*this.f_measured).^2 ./ this.lambda.^4;
        end
    end
    
end

