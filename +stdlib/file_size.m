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

if ~any(i)
  return
elseif isscalar(p)
  d = dir(p);
else
  d = arrayfun(@dir, p(i));
end

i = i & ~isempty(d);
s(i) = [d.bytes];

end
