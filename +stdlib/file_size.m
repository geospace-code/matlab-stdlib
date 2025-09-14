%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * p: path to file
%%% Outputs
% * s: size in bytes; empty if file does not exist

function s = file_size(p)
arguments
  p (1,1) string
end

s = [];

d = dir(p);

if isscalar(d) && ~d.isdir
  s = d.bytes;
end

end
