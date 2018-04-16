function [ ABD ] = CompositeStiffnessABD( plies, theta, ply_thickness )

% source Principles of Composite Material Mechanics - Ronald F. Gibson:
% chapter 7: Analysis of Laminates p207% 
% Forming Stiffness Matrices: A, B, and D

%%%%%%%%%%%%% units %%%%%%%%%%%%%%%
% Principal directions:  C12 - Stiffnes matrix [GPa], S12 - compliance matrix [GPa]
% theta % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
% ply_thickness % [mm] layer thickness, layers: top --> bottom



        A = zeros(3); % [Pa * m] extensional stiffness 
        B = zeros(3); % [Pa * m2] = kN] coupling stiffness
        D = zeros(3); % [Pa * m3] bending stiffness

        total_thickness = sum(ply_thickness);
        MS = total_thickness/2; % MS - middle surface (whateever it means Oo)

        roz = size(ply_thickness);
        roz(:,1)=[];
        z(roz +1) = 0;

        z(1) =  MS - total_thickness;
        for i = 2: (roz+1 )
             z(i) = z(i-1) + ply_thickness(i-1);
        end

         
    for k = 1 : roz % number of layers: top --> bottom
        [ Cxy, ~] = PlyStiffnesXY (plies(k).C12, theta(k));  % transformed coord.
        [ Atemp, Btemp, Dtemp] = PlyStiffnesMatricesABD( Cxy,z(k+1), z(k) ); % PlyStiffnesMatricesABD( C, z_inner, z_outer )
        A = A + Atemp; % [Pa * m]
        B = B + Btemp; % [Pa * m2]
        D = D + Dtemp; % [Pa * m3]
    end

    B = B/2;
    D = D/3;

    ABD = [ A B; B D];
end

