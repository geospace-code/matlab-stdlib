%% WITH_SUFFIX switch file extension
%
%%% Inputs
% * p: path to modify
% * suffix: file extension with "." e.g. ".dat"
%%% Outputs
% * f: modified filename

function f = with_suffix(p, suffix)
arguments
  p string
  suffix {mustBeTextScalar}
end

i = ~lookBehindBoundary("/" | filesep);

pat = (i + "." + alphanumericsPattern + textBoundary('end')) | textBoundary('end');

f = extractBefore(p, pat);

i = strempty(f);
f(i) = p(i);

f = f + suffix;

end
