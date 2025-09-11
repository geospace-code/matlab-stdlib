%% IS_EXE is file executable
% does not check if the file is actually a binary executable
%
%%% inputs
% file: path to check
%%% Outputs
% ok: true if path is a file and has executable permissions
%
% the legacy backend is actually significantly faster for single files

function [ok, b] = is_exe(file)
arguments
  file string
end

if isscalar(file)
  ok = stdlib.legacy.is_exe(file);
  b = 'legacy';
else
  ok = stdlib.native.is_exe(file);
  b = 'native';
end

end
