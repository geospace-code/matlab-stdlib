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
  p string
end

sep = characterListPattern("/" + filesep);

r = repmat("", size(p));

i = startsWith(p, sep);
r(i) = extractBefore(p(i), 2);

if ispc()
  i = startsWith(p, lettersPattern(1) + ":" + sep);
  r(i) = extractBetween(p(i), 3, 3);
end

end
