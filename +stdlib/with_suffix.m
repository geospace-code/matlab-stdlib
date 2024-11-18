function filename = with_suffix(filename, suffix)
%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * filename: original filename
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * filename: modified filename
arguments
  filename (1,1) string
  suffix (1,1) string
end

[direc, name, ext] = fileparts(filename);
if ext ~= suffix
  filename = stdlib.join(direc, name + suffix);
end

end
