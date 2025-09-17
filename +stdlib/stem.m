%% STEM base file name without directory or suffix
%   s = stem(p) returns the stem (base name) of the file specified by the path p.
%   leading dot filenames are allowed.
%
%%% Inputs:
% * p: Character vector or string scalar specifying the file path.
%
%%% Output:
% * s: Character vector or string scalar containing the file name without directory or suffix.
%
% Note: fileparts() was about 100x faster then using multiple steps with pattern.

function s = stem(filepath)

[~, s, e] = fileparts(filepath);

if stdlib.strempty(s)
  s = e;
end

end

%!assert (stdlib.stem('a/b.c'), 'b')