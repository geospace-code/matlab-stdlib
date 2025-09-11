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
  p (1,1) string
end

r = "";

if startsWith(p, ["/", filesep])
  r = extractBefore(p, 2);
elseif ispc() && ~isempty(regexp(p, '^[A-Za-z]:[\\/]','once'))
  r = extractBetween(p, 3, 3);
end

end
