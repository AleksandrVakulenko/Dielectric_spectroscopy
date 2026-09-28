function [Z_mod, theta] = RC_calc_reverse(C, R, Freq, option)
    arguments
        C double
        R double
        Freq double
        option {mustBeMember(option, ["series", "parallel"])}
    end

    Omega = 2 * pi * Freq;

    if option == "series"
        [Z_mod, theta] = RC_calc_reverse_series(C, R, Omega);
    else
        [Z_mod, theta] = RC_calc_reverse_parallel(C, R, Omega);
    end
end


function [Z_mod, theta] = RC_calc_reverse_series(C_ser, R_ser, Omega)

    Z_Re = R_ser;
    Z_Im = -1 / (Omega * C_ser);

    Z_mod = sqrt(Z_Re^2 + Z_Im^2);
    theta = atan2d(Z_Im, Z_Re); 
end


function [Z_mod, theta] = RC_calc_reverse_parallel(C_par, R_par, Omega)
    Y_Re = 1 / R_par;
    Y_Im = Omega * C_par;
    Y_sq = Y_Re^2 + Y_Im^2;

    Z_Re = Y_Re / Y_sq;
    Z_Im = -Y_Im / Y_sq;

    Z_mod = sqrt(Z_Re^2 + Z_Im^2);
    theta = atan2d(Z_Im, Z_Re);
end