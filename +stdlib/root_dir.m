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

matches = regexp(p, '^([/\\])|^[A-Za-z]:([/\\])', 'tokens');

if isempty(matches)

  r = '';
  if isstring(p)
    r = "";
  end

else

  r = matches{1};
  if iscell(r)
    r = r{1};
  end

end

end

%!assert(root_dir(pwd()), filesep)
