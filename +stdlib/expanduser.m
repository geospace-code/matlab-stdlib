%% EXPANDUSER expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
% the string $HOME is not handled.
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * e: expanded path

function e = expanduser(p)
arguments
  p {mustBeTextScalar}
end


pat = ['~[/\', filesep(), ']+|^~$'];

[i0, i1] = regexp(p, pat, 'once');

if isempty(i0)
  % no leading ~ or it's ~user, which we don't handle
  e = p;
  return
end

home = stdlib.homedir();

if i1 - i0 == 0 || strlength(p) == i1
  e = home;
elseif isstring(p)
  e = strjoin([home, extractAfter(p, i1)], filesep());
else
  e = strjoin({home, p(i1:end)}, filesep());
end

if isstring(p)
  e = string(e);
end

end


%!assert(expanduser(''), '')
%!assert(expanduser("~"), homedir())
%!assert(expanduser("~/"), homedir())
%!assert(expanduser("~user"), "~user")
%!assert(expanduser("~user/"), "~user/")
%!assert(expanduser("~/c"), fullfile(homedir(), "c"))
