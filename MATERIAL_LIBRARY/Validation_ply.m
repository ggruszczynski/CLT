classdef Validation_ply < Ply
    
    %                   Validation_ply
    %       CLT vs Autodesk Simulation Composite
    %---------------Ply Material Preperties-------------------
    
    % data: AS/3501 graphite/epoxy from Table 2.2 p48, CTE p229 example 7.9 'Principles of Composite Material Mechanics' Ronald F. Gibson
    
   properties
   end
   
   methods
      function this = Validation_ply(~)     
            this.E1 = 138e9;   %[Pa]
            this.E2 = 9e9;  %[Pa]
            this.G12 = 6.9e9;  %[Pa]
            this.v12 = 0.3; %[-]
            this.v21 = this.v12*(this.E2/this.E1); %[-]
            
  
            this.ALFA12 = [0.88e-6, 31.0e-6 ,0 ]'; % [1/K] The ply CTEs associated with the principal material axes, ALFA12[alfa1, alfa2, 0]

%             C12 % Principal directions:  C - Stiffnes matrix
%             S12 % Principal directions:  S - compliance matrix

            this.thickness = 0.00025; %[m]
            this.rho = 1500; % density[kg/m3]

            [ this.C12, this.S12 ] = PlyStiffnes12 (this, this.E1, this.E2, this.v12, this.v21, this.G12);
            
            this.StressUlt = [1.8075e+08    9.621e+07   5.6665e+07]; %[Pa] Ultimate Stress
      end
 
%       function [ Cxy, Sxy ] = PlyStiffnesXY(this,theta) %matlab needs 'this pointer' as a first input for some reason Oo
%         [ Cxy, Sxy ] = PlyStiffnesXY( this.C12, theta );
%       end
      
   end
   
end