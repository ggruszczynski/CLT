classdef E_errors <  hgsetget
    
    properties (SetAccess = protected)% output
        area_err_abs  %[m2] absolute error in area
        Iyy_err_abs  %[m4] absolute error in moment of inertia
        E_err_abs % [Pa]
        E_err_rel % [Pa]      
    end
        
    properties (Constant) %input
        L_err_abs = 0.002; %[m] absolute error in length
        rho_err_abs = 0.001; %[kg/m3] absolute error in material density 

        f_err_abs = 0.1 * [5, 10, 15] ;% [Hz] absolute error in frequency
        lambda_err_abs = 0.01 * [4.73004 7.85320 10.9956 ]; %[-] absolute error in eigenvalues: free-free eigenvalues (mode shape);  
    end
    
    methods
        function this = E_errors(beam, measured)
            this.area_err_abs = CalcA_err_abs(this, beam);
            this.Iyy_err_abs = CalcIyy_err_abs(this,beam);
            
            this.E_err_abs = Ferr_abs(this,measured);
            this.E_err_rel = Ferr_rel(this,measured);
        end        
        
        
%         function this =  Calculate(this, measured)
%             this.E_err_abs = Ferr_abs(this,measured);
%             this.E_err_rel=Ferr_rel(this,measured);
%         end
        
        function show_results(this,measured)
            for i = 1: numel(measured.E_measured)
                fprintf('E_measured = %0.3g [Pa] \t E_err_abs = %0.3g [Pa] \t E_err_rel = %0.3g [-] \n', measured.E_measured(i), this.E_err_abs(i) , this.E_err_rel(i));
            end
        end
    end
    
    methods(Abstract)  
      ret =  CalcA_err_abs(this,beam)
      ret =  CalcIyy_err_abs(this,beam)
      
    end
    
end

