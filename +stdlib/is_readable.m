%% IS_READABLE is file readable
%
%%% Inputs
% p: string array of file paths
%% Outputs
% ok: logical array of the same size as p, true if file is readable

function y = is_readable(p)
arguments
  p {mustBeTextScalar}
end

if stdlib.has_java()
  y = stdlib.java.is_readable(p);
else
  y = stdlib.native.is_readable(p);
end


end
