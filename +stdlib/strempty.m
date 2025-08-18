%% STREMPTY is the char | string empty
% that means literally string.empty OR strlength == 0

function y = strempty(s)

if isempty(s)
  y = true;
else
  y = strlength(s) == 0;
end

end
