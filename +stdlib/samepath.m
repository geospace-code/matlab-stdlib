%% SAMEPATH is path the same
%
% true if inputs resolve to same path.
% Both paths must exist.
%
% NOTE: in general on Windows same('.', 'not-exist/..') is true, but on
% Unix it is false.
% In C/C++ access() or stat() the same behavior is observed Windows vs Unix.
%
% Ref: https://devblogs.microsoft.com/oldnewthing/20220128-00/?p=106201
%
%%% inputs
% * path1, path2: paths to compare
% * backend: backend to use
%%% Outputs
% * i: true if paths are the same
% * b: backend used

function [i, b] = samepath(path1, path2, backend)
arguments
  path1 {mustBeTextScalar, mustBeFileOrFolder}
  path2 {mustBeTextScalar, mustBeFileOrFolder}
  backend (1,:) string = ["python", "java", "perl", "shell", "native"]
end


i = missing;

for b = backend
  switch b
    case 'java'
      i = stdlib.java.samepath(path1, path2);
    case 'native'
      i = stdlib.native.samepath(path1, path2);
    case 'perl'
      i = stdlib.perl.samepath(path1, path2);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.samepath(path1, path2);
      end
    case 'shell'
      i = stdlib.shell.samepath(path1, path2);
    otherwise
      error('stdlib:samepath:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(i)
    return
  end
end

end
