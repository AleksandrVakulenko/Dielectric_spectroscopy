
% NOTE: calc R[Ohm] and C[F] of series or parallel circuit 
% by |Z|[Ohm] and Phi[deg]

% NOTE: also calc its errors

function [C, R, C_err, R_err] = RC_calc(Z_abs, Z_abs_err, Phi, ...
    Phi_err, Freq, Circuit)

    arguments
        Z_abs double
        Z_abs_err double
        Phi double
        Phi_err double
        Freq double
        Circuit {mustBeMember(Circuit, ["series", "parallel"])}
    end
    
    if Circuit == "series"
        [C, R, C_err, R_err] = RC_calc_series(Z_abs, Z_abs_err, Phi, ...
            Phi_err, Freq);
    else
        [C, R, C_err, R_err] = RC_calc_parallel(Z_abs, Z_abs_err, Phi, ...
            Phi_err, Freq);
    end
end


function [C_par, R_par, C_par_err, R_par_err] = RC_calc_parallel(Z_abs, ...
    Z_abs_err, Phi, Phi_err, Freq)

    Omega = 2*pi*Freq;
    
    Phi_err_rad = Phi_err * pi/180;
    
    R_par = Z_abs/cosd(Phi);
    C_par = -sind(Phi)/(Omega*Z_abs);

    R_par_err = sqrt((Z_abs_err/cosd(Phi))^2 + ...
        ((Phi_err_rad * Z_abs*sind(Phi))/(cosd(Phi))^2)^2);

    C_par_err = abs(1/(Omega*Z_abs)) * sqrt(((sind(Phi)*Z_abs_err)/Z_abs)^2 + ...
        (cosd(Phi) * Phi_err_rad)^2);
end


function [C_ser, R_ser, C_ser_err, R_ser_err] = RC_calc_series(Z_abs, ...
    Z_abs_err, Phi, Phi_err, Freq)

    Omega = 2*pi*Freq;
    Phi_err_rad = Phi_err * pi/180;
    
    R_ser = Z_abs * cosd(Phi);
    C_ser = -1/(Omega*Z_abs*sind(Phi));

    R_ser_err = sqrt((cosd(Phi) * Z_abs_err)^2 + ...
        (Z_abs * sind(Phi) * Phi_err_rad)^2);


    C_ser_err = abs(1/(Omega*Z_abs*(sind(Phi)))) * sqrt((Z_abs_err/Z_abs)^2 + ...
        ((cosd(Phi)*Phi_err_rad)/sind(Phi))^2);
end
