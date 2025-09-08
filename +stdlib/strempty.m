%% STREMPTY is the char | string empty
% that means literally string.empty OR strlength == 0

function y = strempty(s)

if isempty(s)
  y = true;
else
  y = (strlength(s) == 0);
  if isstring(s)
    y = y | ismissing(s);
  end
end

end
