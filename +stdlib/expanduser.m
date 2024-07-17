function e = expanduser(p)
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
end

e = p;

if ~all(startsWith(e, "~")) || (all(strlength(e) > 1) && ~all(startsWith(e, "~/")))
  return
end

home = stdlib.homedir();

if ~isempty(home)
  e = stdlib.join(home, extractAfter(e, 1));
end

end %function
