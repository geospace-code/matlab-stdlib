function expanded = expanduser(p)
%% expanduser(path)
% expands tilde ~ into user home directory
%
% Useful for Matlab functions like h5read() and some Computer Vision toolbox functions
% that can't handle ~
%
%%% Inputs
% * p: path to expand, if tilde present
%%% Outputs
% * expanded: expanded path
%
% See also absolute_path

arguments
  p string
end

expanded = stdlib.fileio.expanduser(p);

end
