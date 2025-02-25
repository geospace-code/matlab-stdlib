%% UNLINK delete file or empty directory
% optional: mex
%
% Matlab or GNU Octave delete() has trouble with not being able to delete
% open files on Windows. This MEX function overcomes that limitation.
% This function returns a boolean success status, which
% delete() does not.
%
%%% Inputs
% * path (1,1) string
%%% Outputs
% * ok (1,1) logical
%
% This function is written in C++ using STL <filesystem>

function ok = unlink(apath)
arguments
  apath (1,1) string
end

%% fallback for if MEX not compiled
try
  delete(apath);
  ok = true;
catch
  ok = false;
end

end
