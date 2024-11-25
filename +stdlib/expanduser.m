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

e = p;


if ~startsWith(e, "~") || (strlength(e) > 1 && ~startsWith(e, "~/"))
  return
end

home = stdlib.homedir(use_java);

if ~isempty(home)
  d = home;
  if strlength(e) < 2
    e = d;
    return
  end

  e = d + "/" + strip(extractAfter(e, 1), "left", "/");
end

end %function
