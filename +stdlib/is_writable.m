%% IS_WRITABLE is path writable
%
%%% Inputs
% * file: path to file or folder
%%% Outputs
% * ok: true if file is writable
%
% the legacy backend is like 40x faster than native

function [ok, b] = is_writable(file)
arguments
  file string
end

if isscalar(file)
  ok = stdlib.legacy.is_writable(file);
  b = 'legacy';
else
  ok = stdlib.native.is_writable(file);
  b = 'native';
end

end
