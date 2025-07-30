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

function rel = relative_to(base, other, method)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
  method (1,:) string = ["python", "native"]
end

fun = choose_method(method, "relative_to");

rel = fun(base, other);

end
