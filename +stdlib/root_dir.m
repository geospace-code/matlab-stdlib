%% ROOT_DIR get root directory
% Examples:

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

r = '';
pc = char(p);

if startsWith(p, {'/', filesep})
  r = pc(1);
elseif strlength(p) > 2 && ~strempty(stdlib.root_name(p))
  if any(pc(3) == ['/', filesep])
    r = pc(3);
  end
end

if isstring(p)
  r = string(r);
end

end

%!assert(root_dir(pwd()) == '/')
