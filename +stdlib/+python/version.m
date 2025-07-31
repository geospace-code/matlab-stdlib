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

% need to have no catch section as glitchy Python load can make TypeError etc.
try %#ok<TRYNC>
  v = pvt_python_version();
end

end
