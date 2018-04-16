function [ Gt] = CalcGt_PlyByPly( obj )
        % CalcGt_PlyByPly calculates the Hypothetical Torsional Modulus [Pa]
       
        % Autodesk Simulation Composite Design user guide:
        % Tubes – Closed symmetrical cross-sections will behave as if they are balanced symmetric even if the layup is not.
        % If the laminate is balanced and symmetric, the entire [B] matrix is zero (due to symmetry) and the in-plane normalshear coupling terms A16, A26 are also equal to zero (due to balance).


        composite = obj.composite;
        
        Btemp = obj.b_inner + 2*obj.total_thickness; % [m] outer dimension of the k-th layer
        btemp = Btemp; % [m] inner dimension of the k-th layer
        
        Htemp = obj.h_inner + 2*obj.total_thickness; % [m] outer dimension of the k-th layer
        htemp= Htemp; % [m] inner dimension of the k-th layer
                         
        roz = numel(composite.thicknesses_of_plies); % number of layers
        
        
        CalculateIo = @(bref, href, ply_thickness)  2*ply_thickness*(bref* href)^2 / (bref + href); %anonymous function
        
        %preallocate
        Gt(roz) = 0;
        Io_ply(roz) = 0;
        GtIo(roz) = 0;

            for k = 1 : roz % iterate through layers: top --> bottom
                btemp = btemp - 2*composite.thicknesses_of_plies(k);
                htemp = htemp - 2*composite.thicknesses_of_plies(k);
                
                href = (Htemp + htemp)/2; %[m] reference height - in the middle of the ply
                bref = (Btemp + btemp)/2; %[m] reference width - in the middle of the ply
                
                %% impose zero-coupling
                [Cxy, ~] = PlyStiffnesXY (composite.plies(k).C12, composite.angles_of_plies(k));  % transformed coord.

                Cxy(1,3) = 0;
                Cxy(2,3) = 0;
                Cxy(3,1) = 0;
                Cxy(3,2) = 0;

                Sxy = Cxy^-1;
                %%
                Gt(k) = 1/Sxy(3,3); % [Pa] Uniaxial shear stiffness of the k-th ply
                Io_ply(k) = CalculateIo( bref, href, composite.thicknesses_of_plies(k));
                GtIo(k) = Gt(k)*Io_ply(k);
 
                Btemp = btemp;
                Htemp = htemp;
            end

        Gt =  sum(GtIo)/sum(Io_ply); % [Pa] Hypothetical Flexural Modulus of the beam
end

