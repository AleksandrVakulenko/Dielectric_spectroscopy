function [C, R, C_err, R_err] = RC_calc(Z_mod, Z_mod_err, theta, ...
    theta_err, Freq, option)

    arguments
        Z_mod double
        Z_mod_err double
        theta double
        theta_err double
        Freq double
        option {mustBeMember(option, ["series", "parallel"])}
    end
    
    if option == "series"
        [C, R, C_err, R_err] = RC_calc_series(Z_mod, Z_mod_err, theta, ...
            theta_err, Freq);
    else
        [C, R, C_err, R_err] = RC_calc_parallel(Z_mod, Z_mod_err, theta, ...
            theta_err, Freq);
    end
end


function [C_par, R_par, C_par_err, R_par_err] = RC_calc_parallel(Z_mod, ...
    Z_mod_err, theta, theta_err, Freq)

    Omega = 2*pi*Freq;
    
    theta_err_rad = theta_err * pi/180;
    
    R_par = Z_mod/cosd(theta);
    C_par = -sind(theta)/(Omega*Z_mod);

    R_par_err = sqrt((Z_mod_err/cosd(theta))^2 + ...
        ((theta_err_rad * Z_mod*sind(theta))/(cosd(theta))^2)^2);

    C_par_err = abs(1/(Omega*Z_mod)) * sqrt(((sind(theta)*Z_mod_err)/Z_mod)^2 + ...
        (cosd(theta) * theta_err_rad)^2);
end


function [C_ser, R_ser, C_ser_err, R_ser_err] = RC_calc_series(Z_mod, ...
    Z_mod_err, theta, theta_err, Freq)

    Omega = 2*pi*Freq;
    theta_err_rad = theta_err * pi/180;
    
    R_ser = Z_mod * cosd(theta);
    C_ser = -1/(Omega*Z_mod*sind(theta));

    R_ser_err = sqrt((cosd(theta) * Z_mod_err)^2 + ...
        (Z_mod * sind(theta) * theta_err_rad)^2);


    C_ser_err = abs(1/(Omega*Z_mod*(sind(theta)))) * sqrt((Z_mod_err/Z_mod)^2 + ...
        ((cosd(theta)*theta_err_rad)/sind(theta))^2);
end