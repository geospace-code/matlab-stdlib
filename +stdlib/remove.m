%% REMOVE delete file or empty directory
% optional: mex
%
% Matlab or GNU Octave delete() has trouble with not being able to delete
% open files on Windows. This function overcomes that limitation by returning
% a boolean success status.

function ok = remove(apath)
arguments
  apath {mustBeTextScalar}
end

%% fallback for if MEX not compiled
try
  delete(apath);
  ok = true;
catch
  ok = false;
end

end
