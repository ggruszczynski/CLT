classdef CustomBeam < Beam
    %CUSTOMBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
%         cross_section = 'rect' %'rect_fillet' or 'rect' or 'pipe'
        
        r_inner % [m] inner radius - pipe
        
        r    %[m] - inner radius of the fillet           
        b   %[m] - beam inner breadth
        h    %[m] - beam inner height   
        
        Io  %[m4] polar moment of inertia (torsion)   
        area  %[m2] 
        Iyy  %[m4] moment of inertia (flexural)
    end
    
    properties (Dependent)    
        r_outer  % [m] outer radius - pipe
    end
    
    methods
          function this =  CustomBeam()     
           if nargin == 0 
              composite = [];
           end
           this = this@Beam(composite);
          end  
        
        
          function ret =  CalcArea()       
             ret = 0;
          end    
         
          function ret=  CalcIyy()       
              ret = 0;
          end    
          
          function ret =  CalcIo()       
              ret = 0;
          end    
          
          function ret = get.r_outer(this)       
              ret = 0;
          end  
          
         function ret = CalcRho()
            ret = 0;
        end
    end
    
end

