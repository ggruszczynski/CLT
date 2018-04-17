function [ Ef] = CalcEf_PlyByPly( obj )
        % CalcEf_PlyByPly calculates the Hypothetical Flexural Modulus [Pa]
        
        % Autodesk Simulation Composite Design user guide:
        % Tubes with Closed symmetrical cross-sections will behave as if they are balanced symmetric even if the layup is not.
        % If the laminate is balanced and symmetric, the entire [B] matrix is zero (due to symmetry) and the in-plane normalshear coupling terms A16, A26 are also equal to zero (due to balance).

        % AUTODESK - BUG - ply numbering system: top --> bottom
		
        composite = obj.composite;
        
        rtemp_inner = obj.r_inner; % [m] inner radius of the k-th layer
        rtemp_outer = obj.r_inner; % [m] outer radius of the k-th layer
            
        roz = numel(composite.thicknesses_of_plies); % number of layers
        CalculateIyy = @(r_outer,r_inner)  (pi/4)*(r_outer^4 -r_inner^4); %anonymous function

        %preallocate
        Ex(roz) = 0;
        Iyy_ply(roz) = 0;
        ExIyy(roz) = 0;

        

            for k = 1 : roz % number of layers: top --> bottom
                rtemp_outer = rtemp_outer + composite.thicknesses_of_plies(k);
                
                %% impose zero-coupling --> Closed symmetrical cross-section
                [Cxy, ~] = PlyStiffnesXY (composite.plies(k).C12, composite.angles_of_plies(k));  % transformed coord.

                Cxy(1,3) = 0;
                Cxy(2,3) = 0;
                Cxy(3,1) = 0;
                Cxy(3,2) = 0;

                Sxy = Cxy^-1;
%                  [~, Sxy] = PlyStiffnesXY (composite.plies(k).C12, composite.angles_of_plies(k));  % transformed coord. - with nonzero coupling
                %%
                Ex(k) = 1/Sxy(1,1); % [Pa] Uniaxial stiffness of the k-th ply     
                
        %% same trick with ABD matrices for single ply - no difference                  
%                          ABD  = CompositeStiffnessABD_ZeroCoupling( composite.plies(k), composite.angles_of_plies(k), composite.thicknesses_of_plies(k) ) ;     
%         %                  ABD  = CompositeStiffnessABD( composite.plies(k), composite.angles_of_plies(k), composite.thicknesses_of_plies(k) ) ; 
%                          ABDinv = inv(ABD);
%                          Ex(k) = 1/(ABDinv(1,1)*composite.thicknesses_of_plies(k)); %[Pa] 
                
                Iyy_ply(k) = CalculateIyy( rtemp_outer, rtemp_inner );
                ExIyy(k) = Ex(k)*Iyy_ply(k);
 
                rtemp_inner = rtemp_outer;
            end
%          Ex
        Ef =  sum(ExIyy)/sum(Iyy_ply); % [Pa] Hypothetical Flexural Modulus of the beam
end

