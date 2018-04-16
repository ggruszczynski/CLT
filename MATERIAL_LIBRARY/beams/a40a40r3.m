%%%%%%%%%%%%%%%%%%%%%%%%% layers' layout convention: top --> bottom %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% beam dimensions %%%%%%%%%%%%%%%
beam_dimensions.cross_section = 'rect_fillet';
beam_dimensions.b = 40*1e-3; %[m] - beam inner breadth
beam_dimensions.h = 40*1e-3; %[m] - beam inner height
beam_dimensions.r = 3.3*1e-3;  %[m] - inner radius of the fillet
beam_dimensions.length = 5;  %[m]

beam_dimensions.angles_of_plies = [ 47,47, 07,07,07,07, 07,07,07,07, 47, 47];   % [deg] angle of rotation (0 degree is the principal direction), layers: top --> bottom
beam_dimensions.thicknesses_of_plies (1:size(beam_dimensions.angles_of_plies,2)) = ply_data.thickness; % [m] all layers (plies) have the same thickness, convention: top --> bottom

beam_dimensions.total_thickness = sum(beam_dimensions.thicknesses_of_plies ); % [m] 
beam_dimensions.Iyy = Iyy( beam_dimensions); %[m4] 
beam_dimensions.area = Area(beam_dimensions); %[m2] 
