%% RELATIVE_TO relative path to base
%
%%% Inputs
% * base {mustBeTextScalar}
% * other {mustBeTextScalar}
%%% Outputs
% * rel {mustBeTextScalar}
%
% Note: Java Path.relativize has an algorithm so different that we choose not to use it.
% javaPathObject(base).relativize(javaPathObject(other))
% https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html#relativize-java.nio.file.Path-

function rel = relative_to(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end

if stdlib.has_python()
  rel = stdlib.python.relative_to(base, other);
else
  rel = stdlib.native.relative_to(base, other);
end

end
