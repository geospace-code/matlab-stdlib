%% ROOT_NAME get root name
% ROOT_NAME(P) returns the root name of P.
% root_name is the drive letter on Windows without the trailing slash
% or an empty string if P is not an absolute path.
% on non-Windows platforms, root_name is always an empty string.


function r = root_name(p)
arguments
  p {mustBeTextScalar}
end

if ispc()
  r = extract(p, textBoundary + lettersPattern(1) + ":");
  if ~isempty(r) && iscell(r)
    r = r{1};
  end
else
  r = '';
end

if isempty(r)
  r = '';
  if isstring(p)
    r = "";
  end
end


end
