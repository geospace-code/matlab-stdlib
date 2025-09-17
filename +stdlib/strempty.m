%% STREMPTY is the char | string empty
% that means literally string.empty OR strlength == 0

function y = strempty(s)

if isempty(s)
  y = true;
elseif ischar(s)
  y = isempty(s);
elseif iscell(s)
  y = strlength(s) == 0;
elseif isstring(s)
  y = (strlength(s) == 0) | ismissing(s);
end

end

%!assert (stdlib.strempty(''))