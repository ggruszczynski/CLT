function [ Iyy ] = FIyy( beam )
%IYY Summary of this function goes here
%   Detailed explanation goes here

cross_section = beam.cross_section; % describes the cross section of the beam, like 'rect', 'rect_fillet', 'pipe'

    switch cross_section
        case 'pipe'
            % r_outer [m]
            % r_inner [m]
            % Iyy [m4]

            Iyy = (pi/4) * (beam.r_outer^4 - beam.r_inner^4);
        case 'rect'  
            % b - inner dimension [m]
            % h - inner dimension [m]
            % thickness [m]
            % Iyy [m4]

            B = beam.b + 2*beam.total_thickness; % outer dimension [m]
            H = beam.h + 2*beam.total_thickness; % outer dimension [m]

            Iyy = (B*H^3 - beam.b*beam.h^3)/12; % [m4] 
        case 'rect_fillet'
            % b - inner dimension [m]
            % h - inner dimension [m]
            % r - inner radius of the fillet[m]
            % t - thickness [m]

            % Iyy [m4]

            R = beam.r + beam.total_thickness;

            I1 = beam.total_thickness*(beam.h-2*beam.r)^3 /12;
            I2 = pi/8 * (1/2 * (R^4 - beam.r^4) + (R^2 - beam.r^2)*(beam.h-2*beam.r)^2);
            I3 = beam.total_thickness*(beam.b-2*beam.r)*(beam.total_thickness^4 /3 + beam.h^2 /4);


            Iyy = 2*I1 + 4*I2 + 2*I3;
        otherwise
            warning('Calculating Iyy(Bending moment of inertia): Unexpected cross section');
    end

end

