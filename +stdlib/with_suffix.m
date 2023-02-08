function filename = with_suffix(filename, suffix)
%% with_suffix(filename, suffix)
% switch file extension
%%% Inputs
% * filename: original filename
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * filename: modified filename
arguments
  filename string
  suffix (1,1) string
end

filename = stdlib.fileio.with_suffix(filename, suffix);

end
