%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * p: path to file
%%% Outputs
% * s: size in bytes, or empty if file does not exist

function s = file_size(p)
arguments
  p {mustBeTextScalar}
end

s = [];

if ~isfile(p)
  return;
end

d = dir(p);
if ~isempty(d)
  s = d.bytes;
end

end
