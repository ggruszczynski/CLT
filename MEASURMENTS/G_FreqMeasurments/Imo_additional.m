classdef Imo_additional <  hgsetget
    %I_ADD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        r_inner % [m] inner radius of the basic inertia unit        
        r_outer % [m] outer radius of the basic inertia unit
        mass_basic % [kg] - mass of the basic inertia unit
        
        Io_basic % [kg*m2] moment of inertia of the one additional inertia unit
        
        distance % [m] - distance from the axis of rotation to the additional inertia unit
        
        n % [-] amount of the additional inertia unit          
    end
    
     properties (Dependent)    
        Io_total %[kg*m2] total mass moment of inertia of the additional inertia unit
     end
    
    methods
        function this = Imo_additional(set_distance)
            this.distance = set_distance;
            this.r_inner = 0.01; % [m]
            this.r_outer = 0.05; % [m]
            this.mass_basic = 10; % [kg]
            this.n = 2;  % [-]
            this.CalcIo_basic();
        end
        
        
                
       function Io_total = get.Io_total(this)       
          Io_total = this.n*(this.Io_basic + this.mass_basic*this.distance^2);
       end 
        
       function CalcIo_basic(this)
            this.Io_basic = 0.5 * this.mass_basic*(this.r_outer^2 + this.r_inner^2);
        end
        
    end
    
end

