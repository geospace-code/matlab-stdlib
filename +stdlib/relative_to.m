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

function rel = relative_to(base, other, backend)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
  backend (1,:) string = ["python", "native"]
end

fun = hbackend(backend, "relative_to");

rel = fun(base, other);

end
