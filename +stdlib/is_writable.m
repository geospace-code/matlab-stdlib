%% IS_WRITABLE is path writable
%
%%% Inputs
% * file: path to file or folder
%% Outputs
% * ok: true if file is writable

function ok = is_writable(file)
arguments
  file string
end

if isscalar(file)
  ok = stdlib.legacy.is_writable(file);
else
  ok = stdlib.native.is_writable(file);
end

end
