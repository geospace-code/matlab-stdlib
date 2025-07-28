%% STREMPTY is the char | string empty

function y = strempty(s)

if isempty(s)
  y = true;
else
  y = strlength(s) == 0;
end


end
