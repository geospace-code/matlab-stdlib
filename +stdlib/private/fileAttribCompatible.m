function [s, r, id] = fileAttribCompatible(file)
%% FILEATTRIBCOMPATIBLE fileattrib required char until R2018a; this provides a seamless fallback
%
% despite fileattrib being deprecated in R2026a, it is not scheduled for removal.

% need stdlib.strempty for Matlab < R2020b
if stdlib.strempty(file)
  r = struct([]);
  s = 0;
  id = 'MATLAB:FILEATTRIB:CannotFindFile';
else
  % char() for Matlab < R2018a
  [s, r, id] = fileattrib(char(file));
end

end
