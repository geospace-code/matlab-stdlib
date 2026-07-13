%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * file: path to file
%%% Outputs
% * s: size in bytes; empty if file does not exist

function s = file_size(file)
arguments
  file {mustBeTextScalar,mustBeFile}
end

d = dir(file);

s = d.bytes;

end
