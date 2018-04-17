classdef G_LM_Errors_pipe < G_LM_Errors

    properties (SetAccess = private)
        R_e_abs = 0.05*1e-3; %[m] absolute error - outer radius
        r_e_abs = 0.05*1e-3; %[m] absolute error - inner radius
    end
    
    methods
        function this =  G_LM_Errors_pipe(set_pipe, set_measurment)
            
            this = this@G_LM_Errors(set_pipe, set_measurment); % call the constructor of the superclass
        end
        
            
        function Io_e_abs =  CalcIo_e_abs(this,pipe)  
           if strcmp(class(pipe), 'Pipe') %class compare
               Io_e_abs= pi*(pipe.r_outer^3 *this.R_e_abs   +    pipe.r_inner^3 *this.r_e_abs); %[m4] absolute error in moment of inertia
           else
               error('its not a pipe ;p its a %s', class(pipe))
           end
           
        end
    end %end_methods
    
end

