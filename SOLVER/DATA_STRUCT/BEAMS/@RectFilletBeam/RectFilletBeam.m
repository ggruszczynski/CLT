classdef RectFilletBeam < Beam
    %RECTFILLETBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        r_inner %[m] - inner radius of the fillet           
        b_inner %[m] - beam inner breadth
        h_inner %[m] - beam inner height   
        
        R_outer %[m] - outer radius of the fillet
        B_outer %[m] - beam outer breadth
        H_outer %[m] - beam outer breadth
        
        
%         Io %[m4] polar moment of inertia (torsion)
    end
    
    properties (Dependent)    
        area %[m2] 
        Iyy %[m4] moment of inertia (flexural)     
    end
    
    methods
     function this =  RectFilletBeam(composite,set_r_inner, set_b_inner, set_h_inner, set_length)  
           if nargin == 0 
              composite = [];
           end
           this = this@Beam(composite);
           if nargin == 0 
                this.r_inner = 0;            
                this.rho = 0; 
                this.length = 0;
           else
                this.r_inner = set_r_inner; 
                this.b_inner = set_b_inner; 
                this.h_inner = set_h_inner; 
                
                this.R_outer = this.r_inner + this.total_thickness;
                this.B_outer = this.b_inner + 2*this.total_thickness;
                this.H_outer = this.h_inner + 2*this.total_thickness;
                
                this.length = set_length;
                this.rho = CalcRho(this);
%               this.Imo = CalcImo(this);               
                

                this.Ef = CalcEf_PlyByPly(this);
                this.Gt = CalcGt_PlyByPly(this);                            
           end     
     end %  end_constructor
           
       Ef = CalcEf_PlyByPly(this)
       Gt = CalcGt_PlyByPly(this)
        
        function ret = CalcRho(this)
          ret = []; 
          warning('CalcRho is not implemented')
        end
        
        
       function ret = get.area(this)       
          ret = CalcArea( this);
       end 
       
       function ret = get.Iyy(this)       
          ret = CalcIyy(this);
       end        
       
       function [ Iyy ] = CalcIyyPly( ~, b , h, r ,t )
            % CalcIyyPly calculates the area moment of inertia of one layer winded around the mandrel. The area moment of inertia or second moment of area has a unit of dimension length4, 
            % and should not be confused with the mass moment of inertia. 

            % b - inner dimension [m]
            % h - inner dimension [m]
            % r - inner radius of the fillet[m]
            % t - thickness [m]

            % Iyy [m4]

            R = r + t;

            I1 = t*(h-2*r)^3 /12;
            I2 = pi/8 * (1/2 * (R^4 - r^4) + (R^2 - r^2)*(h-2*r)^2);
            I3 = t*(b-2*r)*(t^4 /3 + h^2 /4);

            Iyy = 2*I1 + 4*I2 + 2*I3;
       end

       function ret =  CalcIo(~)       
          ret = []; 
          warning('Io is not supported for RectangularFilletBeam')
       end    
    end
    
end

