function [ Gt] = CalcGt_PlyByPly( obj )
        % CalcGt_PlyByPly calculates the Hypothetical Torsional Modulus [Pa]
       
        % Autodesk Simulation Composite Design user guide:
        % Tubes – Closed symmetrical cross-sections will behave as if they are balanced symmetric even if the layup is not.
        % If the laminate is balanced and symmetric, the entire [B] matrix is zero (due to symmetry) and the in-plane normalshear coupling terms A16, A26 are also equal to zero (due to balance).


        composite = obj.composite;
        
        rtemp_outer = obj.r_outer; % [m] outer radius of the k-th layer
        rtemp_inner = obj.r_outer; % [m] inner radius of the k-th layer
            
        roz = numel(composite.thicknesses_of_plies); % number of layers
        CalculateIo = @(r_outer,r_inner)  (pi/2)*(r_outer^4 -r_inner^4); %anonymous function
        
        %preallocate
        Gt(roz) = 0;
        Io_ply(roz) = 0;
        GtIo(roz) = 0;

            for k = 1 : roz % iterate through layers: top --> bottom
                rtemp_inner = rtemp_inner - composite.thicknesses_of_plies(k);
                
                %% impose zero-coupling
                [Cxy, ~] = PlyStiffnesXY (composite.plies(k).C12, composite.angles_of_plies(k));  % transformed coord.

                Cxy(1,3) = 0;
                Cxy(2,3) = 0;
                Cxy(3,1) = 0;
                Cxy(3,2) = 0;

                Sxy = Cxy^-1;
                %%
                Gt(k) = 1/Sxy(3,3); % [Pa] Uniaxial shear stiffness of the k-th ply
                Io_ply(k) = CalculateIo( rtemp_outer, rtemp_inner );
                GtIo(k) = Gt(k)*Io_ply(k);
 
                rtemp_outer = rtemp_inner;
            end

        Gt =  sum(GtIo)/sum(Io_ply); % [Pa] Hypothetical Flexural Modulus of the beam
end

