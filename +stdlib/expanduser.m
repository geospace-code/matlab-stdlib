%% EXPANDUSER expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * e: expanded path

function e = expanduser(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

e = stdlib.drop_slash(p);

L = stdlib.len(e);
if ~L || ~startsWith(e, "~") || (L > 1 && ~startsWith(e, "~/"))
  return
end

home = stdlib.homedir(use_java);

if stdlib.len(home) == 0
  return
end

d = home;
if L < 2
  e = d;
  return
end

if ischar(e)
  e = strcat(d, '/', e(3:end));
else
  e = d + "/" + extractAfter(e, 2);
end

end


%!assert(expanduser('', 0), '')
%!assert(expanduser("~", 0), homedir())
%!assert(expanduser("~/", 0), homedir())
%!assert(expanduser("~user", 0), "~user")
%!assert(expanduser("~user/", 0), "~user")
%!assert(expanduser("~///c", 0), strcat(homedir(), "/c"))
