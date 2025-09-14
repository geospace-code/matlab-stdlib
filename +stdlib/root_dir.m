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

if startsWith(p, ["/", filesep])
  r = extractBefore(p, 2);
elseif ispc()
  r = regexp(p, '(?<=^[A-Za-z]:)([\\/])', 'match', 'once');
  if ismissing(r)
    r = "";
  end
else
  r = extractBefore(p, 1);
end

end
