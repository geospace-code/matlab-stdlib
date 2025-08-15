%% STREMPTY is the char | string empty

function y = strempty(s)

y = isempty(s) | strlength(s) == 0;

end
