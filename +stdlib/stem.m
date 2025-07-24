%% STEM base file name without directory or suffix
% STEM Extracts the file name without directory or suffix from a path.
%   s = stem(p) returns the stem (base name) of the file specified by the path p.
%   leading dot filenames are allowed.
%
%   Input:
%     p - Character vector or string scalar specifying the file path.
%
%   Output:
%     s - Character vector or string scalar containing the file name without directory or suffix.

function s = stem(p)
arguments
  p string
end

p0 = asManyOfPattern(wildcardPattern + ("/" | filesep));
% p1 matches a file extension (e.g., '.txt') or the end of the string
p1 = ("." + alphanumericsPattern + textBoundary('end')) | textBoundary('end');

s = extractBetween(p, p0, p1);

i = strempty(s);
s(i) = extractAfter(p(i), p0);

end
