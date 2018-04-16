function [ Io ] = FIo( beam )
% FIo calculates the polar moment of inertia (torsion) .

cross_section = beam.cross_section; % describes the cross section of the beam, like 'rect', 'rect_fillet', 'pipe'

    switch cross_section
        case 'pipe'
            % r_outer [m]
            % r_inner [m]
            % Io [m4]
            Io= pi/2 * (beam.r_outer^4 - beam.r_inner^4);
        case 'rect' 
            Io = [];
            warning('Calculating Io: rect cross section is not supported');
        case 'rect_fillet'
            Io = [];
            warning('Calculating Io: rect_fillet cross section is not supported');
        otherwise
            warning('Calculating Io: Unexpected cross section');
    end
end

