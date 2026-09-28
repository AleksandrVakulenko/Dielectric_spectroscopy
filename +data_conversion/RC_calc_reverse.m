
% NOTE: calc |Z|[Ohm] and Phi[deg] of series or parallel circuit 
% by R[Ohm] and C[F] values

function [Z_abs, Phi] = RC_calc_reverse(C, R, Freq, Circuit)
    arguments
        C double
        R double
        Freq double
        Circuit {mustBeMember(Circuit, ["series", "parallel"])}
    end

    Omega = 2 * pi * Freq;

    if Circuit == "series"
        [Z_abs, Phi] = RC_calc_reverse_series(C, R, Omega);
    else
        [Z_abs, Phi] = RC_calc_reverse_parallel(C, R, Omega);
    end
end


function [Z_abs, Phi] = RC_calc_reverse_series(C_ser, R_ser, Omega)

    Z_Re = R_ser;
    Z_Im = -1 / (Omega * C_ser);

    Z_abs = sqrt(Z_Re^2 + Z_Im^2);
    Phi = atan2d(Z_Im, Z_Re); 
end


function [Z_abs, Phi] = RC_calc_reverse_parallel(C_par, R_par, Omega)
    Y_Re = 1 / R_par;
    Y_Im = Omega * C_par;
    Y_sq = Y_Re^2 + Y_Im^2;

    Z_Re = Y_Re / Y_sq;
    Z_Im = -Y_Im / Y_sq;

    Z_abs = sqrt(Z_Re^2 + Z_Im^2);
    Phi = atan2d(Z_Im, Z_Re);
end
