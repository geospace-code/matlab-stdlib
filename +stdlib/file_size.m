%% FILE_SIZE size in bytes of file
%
%%% Inputs
% * p: path to file
%%% Outputs
% * s: size in bytes; NaN if file does not exist

function s = file_size(p)
arguments
  p string
end

s = NaN(size(p));

i = isfile(p);

d = arrayfun(@dir, p(i));

i = i & ~isempty(d);
s(i) = [d.bytes];

end
