%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * n: owner, or empty if path does not exist

function n = get_owner(p)
arguments
  p {mustBeTextScalar}
end

n = string.empty;

if ~ispc() && stdlib.has_python()
  n = stdlib.python.get_owner(p);
elseif stdlib.has_java()
  n = stdlib.java.get_owner(p);
end

if strempty(n)
  n = stdlib.sys.get_owner(p);
end

try %#ok<*TRYNC>
  n = string(n);
end

end

%!assert(!isempty(get_owner(pwd)))
