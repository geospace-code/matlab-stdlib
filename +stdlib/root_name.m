%% ROOT_NAME get root name
% ROOT_NAME(P) returns the root name of P.
% root_name is the drive letter on Windows without the trailing slash
% or an empty string if P is not an absolute path.
% on non-Windows platforms, root_name is always an empty string.


function r = root_name(p)

c = char(p);

if ispc() && ~isempty(regexp(c, '^[A-Za-z]:', 'once'))
  r = c(1:2);
else
  r = '';
end

if isstring(p)
  r = string(r);
end

end
