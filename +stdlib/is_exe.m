%% IS_EXE is file executable
% does not check if the file is actually a binary executable
%
%% Inputs
% file: path to check
%% Outputs
% ok: true if path is a file and has executable permissions

function ok = is_exe(file)
arguments
  file string
end

if isscalar(file)
  ok = stdlib.legacy.is_exe(file);
else
  ok = stdlib.native.is_exe(file);
end

end
