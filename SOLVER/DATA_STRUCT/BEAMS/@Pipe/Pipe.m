classdef Pipe < Beam 
    
    %   CPBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties %(SetAccess = private)       
        r_inner % [m] inner radius
        Imo %[kg*m2] mass moment of inertia (torsion)
        w %[rad/s] critical shaft speed (torsional vibrations): fixed-free mode
        w_rpm %[rpm] critical shaft speed (torsional vibrations): fixed-free mode   
    end
    
    properties (Dependent)    
        area %[m2] 
        Iyy %[m4] area moment of inertia (flexural)
        Io  %[m4] polar moment of inertia (torsion)  

        r_outer % [m] outer radius
    end

    
    methods
        function this = Pipe(composite,set_r_inner, set_length)  
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
                this.length = set_length;
                this.rho = CalcRho(this);
                this.Imo = CalcImo(this);               
                
                this.Ef = CalcEf_PlyByPly(this);
                this.Gt = CalcGt_PlyByPly(this);   
                
                this.w = Calcw(this);
                this.w_rpm = 2*pi*this.w/60;               
           end       
        end %end_constructor
        
        
        Ef = CalcEf_PlyByPly(this)
        Gt = CalcGt_PlyByPly(this)
%         function Ef = CalcEf(this)
% %             Ef = Ef_PlyByPly(this.composite, this.r_inner);
%              Ef = 666;
%         end
        
        function Io_bredt = CalcIo_bredt(this) %[m4] polar moment of inertia (torsion) according to Bredt's formula for thin walled profiles == same as Io
            r_ref = (this.r_inner + this.r_outer)/2;
            Io_bredt = 2*pi*this.total_thickness*r_ref^3; %[m4]
        end

        function rho = CalcRho(this)
            rho = 0;
            r_temp = this.r_inner;
            n = numel(this.composite.thicknesses_of_plies );
            A(n) = 0;
            
            for i=1:n
                A(i) = pi *(         (r_temp + this.composite.thicknesses_of_plies(i))^2 - r_temp^2     );
                rho = rho + this.composite.plies(i).rho * A(i);              
                r_temp = r_temp + this.composite.thicknesses_of_plies(i);
            end

            rho = rho/this.area;
        end
        
        function Imo = CalcImo(this)  
            Imo = 0.5*pi*this.length*this.rho*(this.r_outer^4 - this.r_inner^4); %[kg*m2]            
        end

        
        function w = Calcw(this)
            w(3) = 0; %[rad/s]
            for n = 1:3 % take first 3 modes
                w(n) = (n - 0.5)*(pi/this.length)*sqrt(this.Gt/this.rho);
            end
            
%             D = pi*this.Gt*(this.r_outer^4 - this.r_inner^4)/(2*this.length);%[Nm] constant
%             w = sqrt(D/this.Imo); %[rad/s]
        end
        
        function SigX_Pure_Bending = FSigX_Pure_Bending (this,Mb)
            
        rtemp_outer = this.r_outer; % [m] outer radius of the k-th layer             
        roz = numel(this.composite.thicknesses_of_plies); % number of layers
        %preallocate
        Ex(roz) = 0;
        SigX_Pure_Bending(roz) = 0;
            for k = 1 : roz % iterate through layers: top --> bottom
                %% impose zero-coupling --> Closed symmetrical cross-section
                [Cxy, ~] = PlyStiffnesXY (this.composite.plies(k).C12, this.composite.angles_of_plies(k));  % transformed coord.

                Cxy(1,3) = 0;
                Cxy(2,3) = 0;
                Cxy(3,1) = 0;
                Cxy(3,2) = 0;

                Sxy = Cxy^-1;
%                 [~, Sxy] = PlyStiffnesXY (composite.plies(k).C12, composite.angles_of_plies(k));  % transformed coord. - with nonzero coupling
                
                Ex(k) = 1/Sxy(1,1); % [Pa] Uniaxial stiffness of the k-th ply      
                
                SigX_Pure_Bending(k) = Mb* rtemp_outer/this.Iyy * Ex(k)/this.Ef;
                
                rtemp_outer = rtemp_outer - this.composite.thicknesses_of_plies(k);
            end    
        end
        
        
       function ret = get.area(this)       
          ret = CalcArea( this);
       end 
       
       function ret = get.Iyy(this)       
          ret = CalcIyy(this);
       end  
       
       function ret = get.Io(this)       
          ret = CalcIo(this);
       end  
       
       function ret = get.r_outer(this)       
          ret = this.r_inner + this.total_thickness;
       end  
    end %end_methods
    
end %end_classdef

