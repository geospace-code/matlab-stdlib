%% TOO_OLD check if Matlab older than R2020b or as specificed by release "r"
%
% example:
%  too_old("R2020b")    % returns true if Matlab is older than R2020b


function old = too_old(r)

try
    old = isMATLABReleaseOlderThan(r);
catch e
    if e.identifier == "MATLAB:UndefinedFunction"
    old = true;
    else
    rethrow(e)
    end
end

end
