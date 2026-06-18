%% HAS_PARALLEL_TOOLBOX does the user have Parallel Computing Toolbox and the license available for it?
% This checks for the the toolbox and valid license.
% The user can use stdlib.checkout_license() to affirm that the license
% is available at the time of the call.

function y = has_parallel_toolbox()

try
  y = canUseParallelPool();
catch e
  if ~strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    rethrow(e)
  end
  y = false;
end

end
