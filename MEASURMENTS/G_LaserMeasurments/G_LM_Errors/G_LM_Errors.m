classdef G_LM_Errors <  hgsetget
    %G_LM_ERRORS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant) %input
        L_e_abs = 0.002;  %[m] distance between mirrors - absolute error
    end
    
    properties % (SetAccess = protected)% output
        measurment;
        
        Mt_e_abs; %[Nm] torsional moment - absolute error
        
        Io_e_abs; %[m4] polar moment of inertia (torsion) - absolute error
        twist_angle_measured_rad_e_abs; % [rad] measured twist angle - absolute error
        twist_angle_measured_deg_e_abs; % [rad] measured twist angle - absolute error
        
        Mt_e_rel; %[-] torsional moment - relative error
        L_e_rel;  %[-] distance between mirrors - relative error
        Io_e_rel; %[-] polar moment of inertia (torsion) - relative error
        twist_angle_measured_rad_e_rel; % [-] measured twist angle - relative error
        twist_angle_measured_deg_e_rel; % [-] measured twist angle - relative error
        
        G_e_abs; %[Pa] measured shear modulus absolute error
        G_e_rel; %[-] measured shear modulus relative error      
    end
    

    
    methods
        function this = G_LM_Errors(beam, set_measurment)
           this.measurment = set_measurment;

           this.Io_e_abs = CalcIo_e_abs(this,beam);
           this.Mt_e_abs = CalcMt_e_abs(this,this.measurment.x,this.measurment.F); % the first argument 'this' must be instance of the class for some reason Oo
           this.twist_angle_measured_rad_e_abs = CalcTwist_angle_measured_rad_e_abs(this, this.measurment.S);
           this.twist_angle_measured_deg_e_abs = this.twist_angle_measured_rad_e_abs*180/pi;
           
           this.G_e_abs = Ferr_abs(this,set_measurment);
           this.G_e_rel = Ferr_rel(this,set_measurment);
        end        
        
        function Mt_e_abs = CalcMt_e_abs(~,x,F)
            x_e_abs = 1e-3; %[m] arm - absolute error
            F_e_abs = 0.01; %[N] force - absolute error
            Mt_e_abs = F*x_e_abs + x*F_e_abs; %[Nm] moment - absolute error
        end
        
        function twist_angle_measured_rad_e_abs = CalcTwist_angle_measured_rad_e_abs(~,S)
            deltaH_e_abs = 0.002; %[m] deltaH = H2 - H1 difference in height of the reflected laser pointer after applying the moment - absolute error
            S_e_abs = 0.02; %[m] distance from mirror to laser
            twist_angle_measured_rad_e_abs = deltaH_e_abs/(2*S) + S_e_abs/(2*S^2);
        end
        
        
        function show_results(this,measured)
                fprintf('G_measured = %0.3g [Pa] \t G_err_abs = %0.3g [Pa] \t G_err_rel = %0.3g [-] \n', measured.G_measured, this.G_e_abs, this.G_e_rel);
        end
        
    end
    
    methods(Abstract)  
        ret =  CalcIo_e_abs(this,beam) 
    end
    
end

