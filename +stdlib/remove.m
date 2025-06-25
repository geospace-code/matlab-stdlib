%% REMOVE delete file or empty directory
% optional: mex
%
% Matlab or GNU Octave delete() has trouble with not being able to delete
% open files on Windows. This function mitigates that limitation by returning
% a boolean success status.

function ok = remove(apath)
arguments
  apath {mustBeTextScalar}
end

ok = false;

if stdlib.isoctave() && ~stdlib.exists(apath)
  return
end

%% fallback for if MEX not compiled
try %#ok<*TRYNC>
  delete(apath);
  ok = true;
end

[~, id] = lastwarn();

if strcmp(id, 'MATLAB:DELETE:FileNotFound')
  ok = false;
end


end

%!assert(!remove(tempname()))
