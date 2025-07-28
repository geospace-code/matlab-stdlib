%% IS_WRITABLE is path writable
%
%%% Inputs
% p: string array of file paths
%% Outputs
% ok: logical array of the same size as p, true if file is writable

function y = is_writable(p)
arguments
  p {mustBeTextScalar}
end

if stdlib.has_java()
  y = stdlib.java.is_writable(p);
else
  y = stdlib.native.is_writable(p);
end

end
