classdef G_FreqMeasurment  <  hgsetget
    %G_MEASURMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        G_measured %[GPa]
        
        beam 
        
        T %[s] period with additional, movable inertia units
        T0 %[s] period without additional, movable inertia units
        
        Io_add %[m4] additional, movable inertia units
        
    end
    
    methods 
        function this = G_FreqMeasurment(set_beam,set_Io_add, set_T, set_T0)
            this.beam = set_beam;
            this.Io_add = set_Io_add;
            this.T = set_T;        
            this.T0 = set_T0;
            
            this.Calc_G_measured();
        end
        
        function Calc_G_measured(this)
            this.G_measured = 16*this.beam.length*this.Io_add.Io_total*this.beam.Io/(this.T^2 - this.T0^2);
        end
        
    end
    
end

