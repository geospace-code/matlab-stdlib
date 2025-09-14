%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%%% Outputs
% ok: true if file is readable
%
% the legacy backend is like 40x faster than native

function [ok, b] = is_readable(file)
arguments
  file string
end

if isscalar(file)
  ok = stdlib.legacy.is_readable(file);
  b = 'legacy';
else
  ok = stdlib.native.is_readable(file);
  b = 'native';
end

end
