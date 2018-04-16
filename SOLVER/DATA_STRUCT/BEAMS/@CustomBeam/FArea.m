function [ A ] = FArea( beam )

cross_section = beam.cross_section; % describes the cross section of the beam, like 'rect', 'rect_fillet', 'pipe'

    switch cross_section
        case 'pipe'
            % r_outer [m]
            % r_inner [m]
            % A [m2]
            
           A = pi*(beam.r_outer^2 - beam.r_inner^2);%[m2]
        case 'rect' 
            % b - inner breath dimension [m]
            % h - inner height dimension [m]
            % t - thickness [m]
            % A - area [m2]
            
            H = beam.h +2*beam.total_thickness;
            B = beam.b +2*beam.total_thickness;

            A = B*H - beam.b*beam.h; %[m4]  
        case 'rect_fillet'
            % b - inner breath dimension [m]
            % h - inner height dimension [m]
            % t - thickness [m]
            % r - inner radius of the fillet [m]

            % A - area [m2]

            R = beam.r + beam.total_thickness;

            A1 = beam.total_thickness * (beam.h-2*beam.r);
            A2 = pi * (R^2 - beam.r^2)/4;
            A3 = beam.total_thickness * (beam.b-2*beam.r);

            A = 2*A1 + 4*A2 + 2*A3;
        otherwise
            warning('Calculating Area: Unexpected cross section');
    end

end

