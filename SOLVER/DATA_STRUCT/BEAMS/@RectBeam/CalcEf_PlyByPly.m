function [ Ef] = CalcEf_PlyByPly( obj )
        % CalcEf_PlyByPly calculates the Hypothetical Flexural Modulus [Pa]
        
        % Autodesk Simulation Composite Design user guide:
        % Tubes – Closed symmetrical cross-sections will behave as if they are balanced symmetric even if the layup is not.
        % If the laminate is balanced and symmetric, the entire [B] matrix is zero (due to symmetry) and the in-plane normalshear coupling terms A16, A26 are also equal to zero (due to balance).
  
        composite = obj.composite;
        
        Btemp = obj.b_inner + 2*obj.total_thickness; % [m] outer dimension of the k-th layer
        btemp = Btemp; % [m] inner dimension of the k-th layer
        
        Htemp = obj.h_inner + 2*obj.total_thickness; % [m] outer dimension of the k-th layer
        htemp= Htemp; % [m] inner dimension of the k-th layer
                         
        roz = numel(composite.thicknesses_of_plies); % number of layers
              
        CalculateIyy = @(B,H,b,h)  (B*H^3 - b*h^3)/12; % [m4] %anonymous function    
        
        %preallocate
        Ex(roz) = 0;
        Iyy_ply(roz) = 0;
        ExIyy(roz) = 0;

            for k = 1 : roz % iterate through layers: top --> bottom
                btemp = btemp - 2*composite.thicknesses_of_plies(k);
                htemp = htemp - 2*composite.thicknesses_of_plies(k);
                
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
                
                Iyy_ply(k) = CalculateIyy( Btemp,Htemp,btemp,htemp);
                ExIyy(k) = Ex(k)*Iyy_ply(k);
 
                Btemp = btemp;
                Htemp = htemp;
            end
%          Ex
        Ef =  sum(ExIyy)/sum(Iyy_ply); % [Pa] Hypothetical Flexural Modulus of the beam
end

