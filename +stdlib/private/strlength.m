%% STRLENGTH get length of character or scalar string
% assumes single string or character vector
% for GNU Octave until it builds in strlength

function L = strlength(s)

L = [];

if ischar(s)
  L = length(s);
elseif isstring(s)
  L = builtin('strlength', char(s));
end

end

%!assert(strlength('abc'), 3)
