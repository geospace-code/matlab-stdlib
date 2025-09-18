%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * p: path to modify
% * suffix: file extension with '.' e.g. '.dat'
%%% Outputs
% * f: modified filename

function f = with_suffix(p, suffix)

f = extractBefore(p, stdlib.suffix(p));

if stdlib.strempty(f)
  f = p;
end

f = stdlib.append(f, suffix);

end
