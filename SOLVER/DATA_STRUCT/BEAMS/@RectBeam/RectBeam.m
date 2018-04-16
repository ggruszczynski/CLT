classdef RectBeam < Beam
    %CRBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties    
        b_inner   %[m] - beam inner breadth
        h_inner    %[m] - beam inner height   
        
        B_outer %[m] - beam outer breadth
        H_outer %[m] - beam outer breadth
        
%         Io   %[m4] polar moment of inertia (torsion)
    end
     
    properties (Dependent)    
        area %[m2] 
        Iyy %[m4] moment of inertia (flexural)     
    end
    

    
    %% METHODS
    methods
        function this =  RectBeam(composite,set_b_inner, set_h_inner, set_length)  
           if nargin == 0 
              composite = [];
           end
           this = this@Beam(composite);
           if nargin == 0 
                this.r_inner = 0;            
                this.rho = 0; 
                this.length = 0;
           else
                this.b_inner = set_b_inner; 
                this.h_inner = set_h_inner; 
                
                this.B_outer = this.b_inner + 2*this.total_thickness;
                this.H_outer = this.h_inner + 2*this.total_thickness;
                
                this.length = set_length;
                this.rho = CalcRho(this);
%                 this.Imo = CalcImo(this);               
                

                this.Ef = CalcEf_PlyByPly(this);
                this.Gt = CalcGt_PlyByPly(this);   
                                  
           end       
        end %end_constructor
        
       Ef = CalcEf_PlyByPly(this)
       Gt = CalcGt_PlyByPly(this)
        
       function rho = CalcRho(this)
            rho = 0;
            b_temp = this.b_inner;
            h_temp = this.h_inner;
            n = numel(this.composite.thicknesses_of_plies );
            A(n) = 0;
            
            CalculateA = @(B,H,b,h)  (B*H - b*h); % [m2] %anonymous function - calculate area
            
            for i=1:n    
                H_temp = h_temp +2*this.composite.thicknesses_of_plies(i);
                B_temp = b_temp +2*this.composite.thicknesses_of_plies(i);

                A(i) = CalculateA(B_temp,H_temp,b_temp,h_temp);
                
                rho = rho + this.composite.plies(i).rho * A(i);        
                
                b_temp =  H_temp;
                h_temp =  B_temp;
            end

            rho = rho/this.area;
       end
       
       function ret = get.area(this)       
          ret = CalcArea( this);
       end 
       
       function ret = get.Iyy(this)       
          ret = CalcIyy(this);
       end        
       
%        function ret = get.Io(obj)       
%           CalcIo = @(obj) obj.h^3;
%           ret = CalcIo(obj); 
%           warning('Io is not supported for Rectangular Beam')
%        end     
       
       function ret =  CalcIo(~)       
          ret = []; 
          warning('Io is not supported for Rectangular Beam')
       end    
    end %end_methods

end %end_classdef