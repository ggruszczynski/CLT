classdef Composite
    %COMPOSITE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        plies % objects of the class 'Ply'
        ABD  % Stiffness Matrices
        angles_of_plies  % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
        thicknesses_of_plies = [] % [m] all layers (plies) have the same thickness, convention: top --> bottom 
        
        Ex  % [Pa] Effective longitudinal Young's modulus 
            % Ex governs the responce of the laminae under the single axial load per unit length Nx with Ny=Nxy = 0 
            % source: 'Principles of composite materials mechanics' --> chptr7.5.3 Determnination of Laminae engineering constants p220  Ronald F. Gibson
        Ey  % [Pa] Effective transverse Young's modulus 
        Gxy % [Pa] Effective shear modulus 
              
        coupling % [string] - parameter: 'nonzero_coupling' or 'zero_coupling'; use 'zero_coupling' for closed cross-sections

        CTE % CTE for whole composite
    end
    
    methods
        function this = Composite(set_plies, set_theta, set_coupling)
            this.plies = set_plies;
            this.angles_of_plies = set_theta;
            this.coupling = set_coupling;
            
            
            for i=1:numel(set_plies)
                this.thicknesses_of_plies = [this.thicknesses_of_plies, set_plies(i).thickness];
            end

            
            if strcmp(this.coupling,'coupling')
                this.ABD = CompositeStiffnessABD( this.plies, this.angles_of_plies, this.thicknesses_of_plies  );
            elseif strcmp(this.coupling,'zero_coupling')
                this.ABD = CompositeStiffnessABD_ZeroCoupling( this.plies, this.angles_of_plies, this.thicknesses_of_plies  );
            else
                error('Coupling is not set properly. Accepted values are : "zero_coupling" or "coupling" ');
            end
            
            this.Gxy = calcGxy(this);
            [this.Ex ,this.Ey] = calcExEy(this);
            
            this.CTE = calcCTE(this);
        end
        
        function CTE = calcCTE(this)
            i = 1;
            is_cte_data_avail = true;
            while (i < numel(this.plies) + 1)  && (is_cte_data_avail == true)
                is_cte_data_avail = ~isempty(this.plies(i).ALFA12);
                disp(i)
                i = i+1;
            end 
              
            if is_cte_data_avail
            	dTemp = 1; %[K]
            	[Nt_composite, Mt_composite] = calcThermalLoads( this.plies, this.angles_of_plies, this.thicknesses_of_plies, dTemp );
            	MidplaneThermalStrains = this.ABD \ [Nt_composite; Mt_composite];
            	CTE = MidplaneThermalStrains/dTemp;
            else
                disp('CTE data are not available')
                CTE='CTE data are not available';
            end
        end
        
        function Gxy = calcGxy(this)
            ABDinv = inv(this.ABD);
            Gxy = 1/(ABDinv(3,3)*sum(this.thicknesses_of_plies)); % [Pa]
        end
        
        function [Ex,Ey] = calcExEy(this)
            ABDinv = inv(this.ABD);
            Ex = 1/(ABDinv(1,1)*sum(this.thicknesses_of_plies)); %[Pa] 
            Ey = 1/(ABDinv(2,2)*sum(this.thicknesses_of_plies)); %[Pa] 
        end
              
        function [MidplaneThermalStrains, Nt_composite, Mt_composite] = ThermalLoads(this, dTemp) % the composite is unrestrained = free deformation
              [Nt_composite, Mt_composite] = calcThermalLoads( this.plies, this.angles_of_plies, this.thicknesses_of_plies, dTemp );
              MidplaneThermalStrains = this.ABD \ [Nt_composite; Mt_composite];
              warning('Thermal loads are WIP - work in progress');
        end

    end
    
end
