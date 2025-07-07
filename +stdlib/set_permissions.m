%% SET_PERMISSIONS set path permissions
% optional: mex
%
%%% Inputs
% * path {mustBeTextScalar}
% * readable (1,1) int (-1 remove read permission, 0 no change, 1 add read permission)
% * writable (1,1) int (-1 remove write permission, 0 no change, 1 add write permission)
% * executable (1,1) int (-1 remove execute permission, 0 no change, 1 add execute permission)
%%% Outputs
% * ok (1,1) logical

function ok = set_permissions(path, readable, writable, executable)
arguments
  path {mustBeTextScalar,mustBeFile}
  readable (1,1) int8
  writable (1,1) int8
  executable (1,1) int8
end

ok = false;

try
  p = filePermissions(path);
catch e
  switch e.identifier
    case "MATLAB:UndefinedFunction", error("buildtool mex")
    case "MATLAB:io:filesystem:filePermissions:CannotFindLocation", return
    otherwise, rethrow(e)
  end
end

ok = true;

if readable ~= 0
  setPermissions(p, "Readable", readable > 0);
end
if writable ~= 0
  setPermissions(p, "Writable", writable > 0);
end
if executable ~= 0
  setPermissions(p, "Executable", executable > 0);
end

end

%!testif 0
