classdef Ply % < handle
    %   PLY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties %(SetAccess = protected)
        E1 %[Pa] Young's Modulus of the ply  - Longitudinal 
        E2 %[Pa] Young's Modulus of the ply  - Transverse
        G12 %[Pa] Shear Modulus of the ply
        v12 %[-] Poisson's Ratio of the ply - major
        v21 %[-] Poisson's Ratio of the ply - minor
        
        C12 % Principal directions:  C - Stiffnes matrix
        S12 % Principal directions:  S - compliance matrix
        
        ALFA12 % [1/K] The ply CTEs associated with the principal material axes, ALFA12[alfa1, alfa2, 0]
        
        thickness %[m]
        rho % density[kg/m3]
        StressUlt % [Pa] Ultimate strenght [  Sig1,  Sig2,  Sig12]'; 
    end
    
    methods
        function this = Ply(windingdata, fiber, resin)
            if nargin == 0
                disp('Ply constructor is empty...') %%
            else
                
            this.thickness = pi*(windingdata.d_filament/2)^2 *windingdata.n_rolls*windingdata.n_filaments/(windingdata.b_yarn*windingdata.VolF); %[m]
            this.rho = fiber.rhof*windingdata.VolF + resin.rhom*(1-windingdata.VolF);    %[kg/m3]   
            
            [ this.E1, this.E2, this.G12, this.v12, this.v21 ] = MaterialConstants(this, windingdata, fiber, resin); %matlab needs 'this pointer' as a first input for some reason Oo
            [ this.C12, this.S12 ] = PlyStiffnes12 (this, this.E1, this.E2, this.v12, this.v21, this.G12);
            
            this.StressUlt = CalcStressUlt(this,windingdata, fiber,resin);
            end 
        end     
        
        function [ Cxy, Sxy ] = StiffnesXY(this,theta) %matlab needs 'this pointer' as a first input for some reason Oo
            [ Cxy, Sxy ] = PlyStiffnesXY( this.C12, theta );
        end
          
        function StressUlt = CalcStressUlt(this, winding, fiber,resin)
            
            %Longitudinal Tension       
            EpsC = 0:0.001:0.06;      % range of strains of the composite --> for analysis
            [SigC, ~,  ~] =  LongitudinalStrength_Tension (winding.VolF, EpsC, fiber.Ef1, fiber.SigFUlt_1t, resin.Em, resin.SigMUlt_1t); % along fibers
            SigCUlt_1=max(SigC);                           % Ultimate tensile strength of the composite - along fibers
            
             %Transverse Tension
            %  SigCUlt_2 = resin.SigMUlt       % Ultimate strength of the composite - perpendicular to fibers (matrix tensile failure)
             SigCUlt_2 = TransverseStrength_Tension( this.E2, resin.Em, fiber.Ef2, resin.SigMUlt_1t, winding.VolF ); % apply stress concentration factor

             %Shear
            %  SigCUlt_12 = resin.SigMUlt/2  % Ultimate strength of the composite -  simplify as shear failure of the matrix according to Tresca  
             SigMUlt_12 = resin.SigMUlt_1t/2;  % Ultimate shear strength of the matrix -  simplify as shear failure of the matrix according to Tresca 
             SigCUlt_12 = ShearStrength( this.G12, resin.Gm, fiber.Gf, SigMUlt_12, winding.VolF ); % apply shear stress concentration factor

            % vector form
            StressUlt = [  SigCUlt_1,  SigCUlt_2,  SigCUlt_12]; 
        end
    end %end_methods
    
end

