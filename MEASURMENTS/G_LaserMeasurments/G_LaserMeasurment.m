classdef G_LaserMeasurment <  hgsetget
    %G_LASERMEASURMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess = private) % only the defining class can set property values. You can change the value of an object property only if the class defines a method to perform this action.
%         beam = Pipe;       
        twist_angle_expected_rad; % [rad] expected twist angle
        twist_angle_expected_deg; % [deg] expected twist angle
        
        L; %[m] distance between mirrors
        S; %[m] distance from mirror to laser
        deltaH; %[m] deltaH = H2 - H1  difference in height of the reflected laser pointer after applying the moment
        
        F; % [N] the force
        x; % [m] arm of the force
        Mt; %[Nm] torsional moment

        twist_angle_measured_rad; % [rad] measured twist angle     
        twist_angle_measured_deg; % [deg] measured twist angle     
        Io_measured; %[m4] measured second moment of area (polar,torsion)
        G_measured; %[Pa] measured shear modulus
    end
    
    methods 
        function this = G_LaserMeasurment(beam, set_F, set_x, set_L, set_S, set_deltaH)
%             this.beam = beam;
            this.F = set_F;
            this.x = set_x;
            this.Mt = this.F* this.x;
            this.L = set_L;
            this.S = set_S;
            this.deltaH = set_deltaH;
            
            this.twist_angle_measured_rad = this.deltaH/(2*this.S); %[rad]
            this.twist_angle_measured_deg = this.twist_angle_measured_rad *180/pi;       %[deg]
            
            this.twist_angle_expected_rad = FreeF_twist( this.Mt, this.L, beam.Gt, beam.Io ); %[rad]
            this.twist_angle_expected_deg = this.twist_angle_expected_rad *180/pi;       %[deg]
            
            this.Io_measured = beam.Io; %% lets trick ;p (a measured value should be used instead of calculated Io)
            this.G_measured = FCalc_G(this);
        end
        
        
        function  G_measured = FCalc_G(this)
            G_measured = this.Mt * this.L/(this.Io_measured*this.twist_angle_measured_rad); %[Pa]
        end
    end
    
end

