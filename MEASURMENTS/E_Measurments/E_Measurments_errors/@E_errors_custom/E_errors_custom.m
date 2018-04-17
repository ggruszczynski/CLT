classdef E_errors_custom < E_errors

    properties 

    end
    
    methods
        function this =  E_errors_custom(beam, measured)
            this = this@E_errors(beam, measured); % call the constructor of the superclass
        end
        
        
        function area_err_abs =  CalcA_err_abs(this,beam)
            area_err_abs = 0.01*1e-4; %[m2] absolute error in area
        end
            
        function Iyy_err_abs =  CalcIyy_err_abs(this,beam)  
            Iyy_err_abs = 0.01*1e-8; %[m4] absolute error in moment of inertia
        end
    end %end_methods
    
end

