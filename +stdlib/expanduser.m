function e = expanduser(p, use_java)
%% expanduser(path)
% expands tilde ~ into user home directory
%
% Useful for Matlab functions that can't handle ~
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * expanded: expanded path
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

e = p;

if ~all(startsWith(e, "~")) || (all(strlength(e) > 1) && ~all(startsWith(e, "~/")))
  return
end

home = stdlib.homedir(use_java);

if ~isempty(home)
  e = stdlib.join(home, extractAfter(e, 1));
end

end %function
