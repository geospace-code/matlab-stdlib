function expanded = expanduser(p)
%% expanduser(path)
% expands tilde ~ into user home directory
%
% Useful for Matlab functions like h5read() and some Computer Vision toolbox functions
% that can't handle ~
%% Inputs
% * p: path to expand, if tilde present
%% Outputs
% * expanded: expanded path
%
% See also ABSOLUTE_PATH

arguments
  p string
end

expanded = p;

if ispc
  home = getenv('USERPROFILE');
else
  home = getenv('HOME');
end

if ~isempty(home)
  i = startsWith(expanded, "~");
  expanded(i) = fullfile(home, extractAfter(expanded(i), 1));
end

end %function
