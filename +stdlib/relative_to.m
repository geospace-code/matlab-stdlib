%% RELATIVE_TO relative path to base
%
%%% Inputs
% * base: directory to which the other path should be relative
% * other: path to be made relative
% * backend: backend to use
%%% Outputs
% * rel: relative path from base to other
% * b: backend used
%
% Note: Java Path.relativize has an algorithm so different that we choose not to use it.
% javaPathObject(base).relativize(javaPathObject(other))
% https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html#relativize-java.nio.file.Path-

function [rel, b] = relative_to(base, other, backend)
arguments
  base (1,1) string
  other (1,1) string
  backend (1,:) string = ["native", "python"]
end

o = stdlib.Backend(mfilename(), backend);
rel = o.func(base, other);
b = o.backend;

end
