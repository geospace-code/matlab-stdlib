%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%%% Outputs
% ok: true if file is readable

function ok = is_readable(file)
arguments
  file string
end

if isscalar(file)
  ok = stdlib.legacy.is_readable(file);
else
  ok = stdlib.native.is_readable(file);
end

end
