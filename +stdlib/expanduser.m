%% EXPANDUSER expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * e: expanded path

function e = expanduser(p)
arguments
  p (1,1) string
end

e = stdlib.posix(p);

L = stdlib.len(e);
if ~L || ~startsWith(e, "~") || (L > 1 && ~startsWith(e, "~/"))
  return
end

home = stdlib.homedir();
if ~stdlib.len(home), return, end

if L < 2
  e = home;
  return
end

if ischar(e)
  e = strcat(home, '/', e(3:end));
else
  e = home + "/" + extractAfter(e, 2);
end

end


%!assert(expanduser(''), '')
%!assert(expanduser("~"), homedir())
%!assert(expanduser("~/"), homedir())
%!assert(expanduser("~user"), "~user")
%!assert(expanduser("~user/"), "~user")
%!assert(expanduser("~///c"), strcat(homedir(), "/c"))
