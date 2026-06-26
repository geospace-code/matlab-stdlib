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

r = '';

if stdlib.strempty(p)
  r = p;
elseif ismember(p(1), {'/', filesep})
  r = extractBefore(p, 2);
elseif ispc()
  m = regexp(p, '^[A-Za-z]:([\\/])', 'tokens', 'once');
  if ~isempty(m)
    r = m{1};
  end
end

if isstring(p)
  r = string(r);
end

end
