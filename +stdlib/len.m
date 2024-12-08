%% LEN get length of character or string
% assumes single string or character vector
% to ease GNU Octave compatibility

function L = len(s)

L = [];

if ischar(s)
  L = length(s);
elseif isstring(s)
  L = strlength(s);
end

end
