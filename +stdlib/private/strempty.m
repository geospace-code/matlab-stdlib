%% STREMPTY is the char / string empty

function y = strempty(s)
arguments
  s {mustBeTextScalar}
end

y = strlength(s) == 0;

end