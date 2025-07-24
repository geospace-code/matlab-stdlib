%% ROOT_DIR get root directory
% Examples:
%
%% Windows
% * root_dir('C:\path\to\file') returns '\'
% * root_dir('C:path\to\file') returns ''
%% Unix
% * root_dir('/path/to/file') returns '/'
% * root_dir('path/to/file') returns ''

function r = root_dir(p)
arguments
  p {mustBeTextScalar}
end

sep = characterListPattern("/" + filesep);
pat = (textBoundary + sep);
if ispc()
  pat = pat | (lookBehindBoundary(lettersPattern(1) + ":") + sep);
end

r = extract(p, pat);
if isempty(r)
  r = '';
  if isstring(p)
    r = "";
  end
elseif iscell(r)
  r = r{1};
end

end

%!assert(root_dir(pwd()), filesep)
