%% IS_WRITABLE is path writable
%
%%% Inputs
% file: path to file or folder
%% Outputs
% ok: true if file is writable

function y = is_writable(file)
arguments
  file {mustBeTextScalar}
end

if stdlib.has_java()
  y = stdlib.java.is_writable(file);
elseif isMATLABReleaseOlderThan('R2025a')
  y = stdlib.native.is_writable_legacy(file);
else
  y = stdlib.native.is_writable(file);
end

end
