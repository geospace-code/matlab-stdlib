%% STRLENGTH get length of character or scalar string
% assumes single string or character vector
% for GNU Octave until it builds in strlength

function L = strlength(s)

L = [];

if ischar(s)
  L = length(s);
elseif isstring(s)
  L = builtin('strlength', char(s));
  % bug in Matlab at least through R2025a confirmed by Xinyue Xia of Mathworks Technical Support
  % only works for char and scalar strings until fixed by Mathworks.
  % once fixed, wouldn't need char(s) conversion.
end

end

%!assert(strlength('abc'), 3)
