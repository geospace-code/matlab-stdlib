%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * file: path to file
%%% Outputs
% * s: size in bytes; empty if file does not exist

function s = file_size(file)

s = [];

% char() for Matlab < R2018a
d = dir(char(file));

if isscalar(d) && ~d.isdir
  s = d.bytes;
end

end
