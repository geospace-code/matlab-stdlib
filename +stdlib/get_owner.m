%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * n: owner, or empty if path does not exist

function n = get_owner(p)
arguments
  p {mustBeTextScalar}
end


if ~ispc() && stdlib.has_python()

  n = string(py.str(py.pathlib.Path(p).owner()));

elseif stdlib.has_java()
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

  opt = javaMethod("values", "java.nio.file.LinkOption");

  n = javaMethod("getOwner", "java.nio.file.Files", javaPathObject(p), opt).toString();
  % .toString() needed for Octave

  try %#ok<*TRYNC>
    n = string(n);
  end

end

end

%!assert(!isempty(get_owner(pwd)))
