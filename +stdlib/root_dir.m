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

c = char(p);
r = '';

if isempty(c)
  % pass
elseif ismember(c(1), {'/', filesep})
  r = c(1);
elseif ispc()
  m = regexp(c, '^[A-Za-z]:([\\/])', 'tokens', 'once');
  if ~isempty(m)
    r = m{1};
  end
end

if isstring(p)
  r = string(r);
end

end

%!test
%! if ispc()
%!   assert(strcmp(strcmp.root_dir('c:/hi'), '/'))
%! else
%!   assert(strcmp(stdlib.root_dir('/a/.bc'), '/'))
%! end
