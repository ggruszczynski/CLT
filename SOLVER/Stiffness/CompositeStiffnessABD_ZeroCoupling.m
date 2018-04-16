function [ ABD ] = CompositeStiffnessABD_ZeroCoupling( plies, theta, ply_thickness )

% source Principles of Composite Material Mechanics - Ronald F. Gibson:
% chapter 7: Analysis of Laminates p207% 
% Forming Stiffness Matrices: A, B, and D

%%%%%%%%%%%%% units %%%%%%%%%%%%%%%
% Principal directions:  C12 - Stiffnes matrix [GPa], S12 - compliance matrix [GPa]
% theta % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
% ply_thickness % [mm] layer thickness, layers: top --> bottom

% Autodesk Simulation Composite Design user guide:
% Tubes – Closed symmetrical cross-sections will behave as if they are balanced symmetric even if the layup is not.
% If the laminate is balanced and symmetric, the entire [B] matrix is zero (due to symmetry) and the in-plane normalshear coupling terms A16, A26 are also equal to zero (due to balance).

        A = zeros(3); % [Pa * mm] extensional stiffness 
        B = zeros(3); % [Pa * mm2 = kN] coupling stiffness
        D = zeros(3); % [Pa * mm3] bending stiffness

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
    [ Atemp, ~, Dtemp] = PlyStiffnesMatricesABD( Cxy,z(k+1), z(k) );
    A = A + Atemp; % [Pa * m]
   % B = B + Btemp; % [Pa * m2]
    D = D + Dtemp; % [Pa * m3]
end

%% Zero coupling - implementiation
A(1,3) = 0;
A(2,3) = 0;
A(3,1) = 0;
A(3,2) = 0;

% B is kept as zero after initialization
%B = B/2;
%%

D = D/3;

ABD = [ A B; B D];
end

