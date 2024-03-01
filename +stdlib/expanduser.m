function expanded = expanduser(p)
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

expanded = stdlib.fileio.expanduser(p);

end
