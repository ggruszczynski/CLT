
%%%%%%%%%%%%%%%%%%%%%%%%% layers' layout convention: top --> bottom %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    beam_dimensions.cross_section = 'rect';
    beam_dimensions.b = 40*1e-3; %[m] - beam inner breadth
    beam_dimensions.h = 40*1e-3; %[m] - beam inner height
    beam_dimensions.r = 0;  %[m] - inner radius of the fillet
    beam_dimensions.length = 5;  %[m]

%     beam_dimensions.angles_of_plies = [ 90, 60, 30, 0, 0, 0, 0, 0];   % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
%     beam_dimensions.angles_of_plies = [ 45, 45, 45, 45, 45, 45, 45, 45];   % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
%     beam_dimensions.angles_of_plies = [ 5, 5, 5, 5, 5, 5, 5, 5];   % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
%     beam_dimensions.angles_of_plies = [ 0, 0, 0, 0, 0, 0, 0, 0];   % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
    beam_dimensions.angles_of_plies = [ 90, 30, 30, 30, 30, 30, 30, 30];   % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
    beam_dimensions.thicknesses_of_plies (1:size(beam_dimensions.angles_of_plies,2)) = ply_data.thickness; % [m] all layers (plies) have the same thickness, convention: top --> bottom

    beam_dimensions.total_thickness = sum(beam_dimensions.thicknesses_of_plies ); % [m] 
    beam_dimensions.Iyy = Iyy( beam_dimensions); %[m4] 
    beam_dimensions.area = Area(beam_dimensions); %[m2] 
