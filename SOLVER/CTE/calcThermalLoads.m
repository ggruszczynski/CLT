function [ Nt_composite, Mt_composite ] = calcThermalLoads(plies, theta, ply_thickness, dTemp )

%%%%%%%%%%%%% units %%%%%%%%%%%%%%%
% Principal directions:  C12 - Stiffnes matrix [Pa], S12 - compliance matrix [Pa]
% theta % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
% ply_thickness % [mm] layer thickness, layers: top --> bottom

% ALFA - vector of CTE[alfa_x, alfa_y, alfa_xy]
% z_outer - distance from the middle surface to the outer surface of the ply (top --> bottom till MS, then the notation switches ;) )
% z_inner - distance from the middle surface to the inner surface of the ply
% dTemp - temperature change [K]

%%%%%%%% output %%%%%%%%%%
% Nt_composite % [Pa-m]  [Nx,Ny,Nxy] ThermalLoads - force
% Mt_composite % [Pa-m2] [Mx,My,Mxy] ThermalLoads - moment

        total_thickness = sum(ply_thickness);
        MS = total_thickness/2; % MS - middle surface (whateever it means Oo)

        roz = numel(ply_thickness);
        z(roz +1) = 0;

        z(1) =  MS - total_thickness;
        for i = 2: (roz+1 )
             z(i) = z(i-1) + ply_thickness(i-1);
        end
            
    ALFAXY(3,roz) = 0; % CTE for k-th ply: [ alfa_x, alfa_y, alfa_xy] note that the third element in the vector ALFAXY is returned as alfa_xy not alfa_xy/2
    Nt_ply(3,roz) = 0; % Thermal forces [Nx, Ny, Nxy] for k-th ply [Pa - m]
    Mt_ply(3,roz) = 0; % Thermal moments [Mx, My, Mxy] for k-th ply [Pa - m2]

    for k = 1: 1 : roz
        ALFAXY(:,k) = CTEplyXY( plies(k).ALFA12, theta(k));
        [ Cxy, ~] = PlyStiffnesXY (plies(k).C12, theta(k));  % transformed coord.
        
        Nt_ply(:,k)  = NThermal_ply( Cxy, ALFAXY(:,k), z(k+1), z(k) , dTemp );
        Mt_ply(:,k)  = MThermal_ply( Cxy, ALFAXY(:,k), z(k+1), z(k) , dTemp );
    end

    Nt_composite = sum(Nt_ply,2); % sum(X,DIM) sums along the dimension DIM. 
    Mt_composite = sum(Mt_ply,2);
 
end

