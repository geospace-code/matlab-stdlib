%% HAS_PARALLEL_TOOLBOX does the user have Parallel Computing Toolbox and the license available for it?
% This deliberately doesn't catch the case where the toolbox and license is valid, but there aren't
% enough licenses, so that the user knows what's happening.
% The user can use stdlib.checkout_license() to affirm that the license is available at the time of the call.

function y = has_parallel_toolbox()

try
  gcp('nocreate');
  y = true;
catch e
  if e.identifier ~= "MATLAB:UndefinedFunction"
    rethrow(e)
  end
  y = false;
end

end
