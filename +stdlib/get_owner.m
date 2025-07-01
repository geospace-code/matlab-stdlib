%% GET_OWNER owner of file or directory
% requires: java
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * n: owner, or empty if path does not exist
function n = get_owner(p)
arguments
  p {mustBeTextScalar}
end

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

op = javaPathObject(p);
opt = javaLinkOption();

if stdlib.isoctave()
  n = javaMethod("getOwner", "java.nio.file.Files", op, opt).toString();
else
  n = java.nio.file.Files.getOwner(op, opt).string;
end

end

%!assert(!isempty(get_owner(pwd)))
