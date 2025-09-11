%% ROOT_NAME get root name
% ROOT_NAME(P) returns the root name of P.
% root_name is the drive letter on Windows without the trailing slash
% or an empty string if P is not an absolute path.
% on non-Windows platforms, root_name is always an empty string.


function r = root_name(p)
arguments
  p (1,1) string
end

r = "";

if ispc() && ~isempty(regexp(p, '^[A-Za-z]:', 'once'))
  r = extractBefore(p, 3);
end

end
