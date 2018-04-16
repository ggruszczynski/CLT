function [ Ef] = CalcEf_PlyByPly( obj )
    % CalcEf_PlyByPly calculates the Hypothetical Flexural Modulus [Pa]

    % Autodesk Simulation Composite Design user guide:
    % Tubes – Closed symmetrical cross-sections will behave as if they are balanced symmetric even if the layup is not.
    % If the laminate is balanced and symmetric, the entire [B] matrix is zero (due to symmetry) and the in-plane normalshear coupling terms A16, A26 are also equal to zero (due to balance).

    composite = obj.composite;

    btemp = obj.b_inner + 2*obj.total_thickness; 
    htemp = obj.h_inner + 2*obj.total_thickness; 
    rtemp = obj.r_inner + obj.total_thickness;  

    roz = numel(composite.thicknesses_of_plies); % number of layers    

    %preallocate
    Ex(roz) = 0;
    Iyy_ply(roz) = 0;
    ExIyy(roz) = 0;

        for k = 1 : roz % iterate through layers: top --> bottom
            btemp = btemp - 2*composite.thicknesses_of_plies(k);  % [m] inner dimension of the k-th layer
            htemp = htemp - 2*composite.thicknesses_of_plies(k);  % [m] inner dimension of the k-th layer 
            rtemp = rtemp - composite.thicknesses_of_plies(k);    % [m] inner radius of the k-th layer  

            %% impose zero-coupling --> Closed symmetrical cross-section
            [Cxy, ~] = PlyStiffnesXY (composite.plies(k).C12, composite.angles_of_plies(k));  % transformed coord.

            Cxy(1,3) = 0;
            Cxy(2,3) = 0;
            Cxy(3,1) = 0;
            Cxy(3,2) = 0;

            Sxy = Cxy^-1;
            %%
            Ex(k) = 1/Sxy(1,1); % [Pa] Uniaxial stiffness of the k-th ply     

            Iyy_ply(k) = obj.CalcIyyPly( btemp , htemp, rtemp ,composite.thicknesses_of_plies(k));
            ExIyy(k) = Ex(k)*Iyy_ply(k);
        end
   Ef =  sum(ExIyy)/sum(Iyy_ply); % [Pa] Hypothetical Flexural Modulus of the beam
end

