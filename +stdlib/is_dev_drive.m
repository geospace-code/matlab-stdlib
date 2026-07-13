%% IS_DEV_DRIVE is path on a Windows Dev Drive developer volume
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: true if path is a Dev Drive
% * b: backend used

function [i, b] = is_dev_drive(file, backend)
arguments
  file {mustBeTextScalar,mustBeFolder}
  backend (1,:) string = ["python", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
