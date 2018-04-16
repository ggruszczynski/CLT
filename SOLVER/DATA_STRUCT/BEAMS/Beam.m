classdef Beam  <  hgsetget
 
    properties %(SetAccess = protected)   
        length  %[m]             
        composite = Composite.empty(1,0);    
        rho  %[kg/m3] material density          
        total_thickness % [m] 
        
         Ef  % [Pa] Hypothetical Flexural Modulus of the beam
         Gt  % [Pa] Hypothetical Shear Modulus of the beam
    end %end_properties
    

    properties (Abstract) % matlab does not allow to change the access (private/public) of the abstract properties in derived classes
         area %[m2] 
         Iyy % [m4] area moment of inertia (flexural)
%        Io  % [m4] polar moment of inertia (torsion)  

    end %end_Abstract_properties
      
    methods
        
        function this = Beam(set_composite)
            if ~isa(set_composite,'Composite')
                warning('Beam constructor is called improperly / without parameters ') %%
                this.rho = 0;      
                this.total_thickness = 0;
            elseif nargin > 0
                this.composite = set_composite;            
                this.total_thickness = sum(this.composite.thicknesses_of_plies );     
            else
                warning('Beam constructor is called without parameters') %%
                this.rho = 0;      
                this.total_thickness = 0;
            end
        end

    end %end_methods
    
    methods(Abstract)        
        result = CalcRho(obj)
        result = CalcIyy(obj)
        result = CalcArea(obj)
        result = CalcIo(obj)
%         result = CalcEf_PlyByPly(obj)
    end %end_Abstract_methods
end


%         function ret = get.rho(obj)
%           ret = CalcRho(obj);
%         end 
%         
%         function obj = set.rho(obj,~)
%           fprintf('%s%d\n','rho is: ',obj.rho)
%           error('You cannot set rhi explicitly'); 
%         end 
%         
%         function ret = get.total_thickness(obj)
%           ret = sum(obj.composite.thicknesses_of_plies );
%         end % total_thickness get method
%         
%         function obj = set.total_thickness(obj,~)
%           fprintf('%s%d\n','total_thickness is: ',obj.total_thickness)
%           error('You cannot set total_thickness explicitly'); 
%         end     
