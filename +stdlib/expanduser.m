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

e = "";

if stdlib.is_url(p), return; end

e = stdlib.drop_slash(p);

L = stdlib.len(e);
if ~L || ~startsWith(e, "~") || (L > 1 && ~startsWith(e, "~/"))
  return
end

home = stdlib.homedir();

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


%!assert(expanduser(''), '')
%!assert(expanduser("~"), homedir())
%!assert(expanduser("~/"), homedir())
%!assert(expanduser("~user"), "~user")
%!assert(expanduser("~user/"), "~user")
%!assert(expanduser("~///c"), strcat(homedir(), "/c"))
