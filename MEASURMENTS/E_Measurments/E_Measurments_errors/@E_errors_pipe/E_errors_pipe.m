classdef E_errors_pipe < E_errors

    properties (SetAccess = private)
        r_outer_err_abs = 0*0.05*1e-3; %[m] absolute error - outer radius
        r_inner_err_abs = 0*0.05*1e-3; %[m] absolute error - inner radius
    end
    
    methods
        function this =  E_errors_pipe(beam, measured)
            this = this@E_errors(beam, measured); % call the constructor of the superclass
        end
        
        
        function area_err_abs =  CalcA_err_abs(this,pipe)
           if strcmp(class(pipe), 'Pipe') %class compare
               area_err_abs = 2*pi*(pipe.r_outer*this.r_outer_err_abs    +    pipe.r_inner*this.r_inner_err_abs); %[m2] absolute error in area 
           else
               error('its not a pipe ;p its a %s', class(pipe))
           end           
        end
            
        function Iyy_err_abs =  CalcIyy_err_abs(this,pipe)  
           if strcmp(class(pipe), 'Pipe') %class compare
               Iyy_err_abs= pi*(pipe.r_outer^3 *this.r_outer_err_abs    +    pipe.r_inner^3 *this.r_inner_err_abs); %[m4] absolute error in moment of inertia
           else
               error('its not a pipe ;p its a %s', class(pipe))
           end
           
        end
    end %end_methods
    
end

