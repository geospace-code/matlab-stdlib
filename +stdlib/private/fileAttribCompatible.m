%% FILEATTRIBCOMPATIBLE fileattrib required char until R2018a; this provides a seamless fallback

function [s, r, id] = fileAttribCompatible(file)

% need stdlib.strempty for Matlab < R2020b
if stdlib.strempty(file)
  r = struct.empty;
  s = 0;
  id = 'MATLAB:FILEATTRIB:CannotFindFile';
  return
end


try
  [s, r, id] = fileattrib(file);
catch e
  if strcmp(e.identifier, 'MATLAB:string')
    [s, r, id] = fileattrib(char(file));
  else
    rethrow(e)
  end
end

end
