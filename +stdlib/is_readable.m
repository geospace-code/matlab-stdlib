%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%% Outputs
% ok: true if file is readable

function y = is_readable(file)
arguments
  file {mustBeTextScalar}
end

if stdlib.has_java()
  y = stdlib.java.is_readable(file);
elseif isMATLABReleaseOlderThan('R2025a')
  y = stdlib.native.is_readable_legacy(file);
else
  y = stdlib.native.is_readable(file);
end

end
