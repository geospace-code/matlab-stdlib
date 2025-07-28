%% PYTHON.VERSION major.minor version of the Python executable being used

function v = version(force_old)
arguments
  force_old (1,1) logical = false
end

% Matlab < R2022a has a bug in the JIT compiler that breaks try-catch
% for any py.* command. 
% We use a separate private function to workaround that.

v = [];

if isMATLABReleaseOlderThan('R2022a') && ~force_old
  return
end

try
  v = pvt_python_version();
catch e
  switch e.identifier
    case {'Octave:undefined-function', 'MATLAB:Python:PythonUnavailable'}  % pass
    otherwise, rethrow(e)
  end
end

end
