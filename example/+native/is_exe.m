function y = is_exe(file)
arguments
  file string
end

y = false;

if ispc() && ~stdlib.native.has_windows_executable_suffix(file)
  return
end

if isunix
  props = ["UserExecute", "GroupExecute", "OtherExecute"];
else
  props = "Readable";
end

try
  y = getPermissions(filePermissions(file), props);
catch e
  switch e.identifier
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      y = logical.empty;
    otherwise
      rethrow(e)
  end
end

end
