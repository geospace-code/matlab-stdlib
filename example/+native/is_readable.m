function y = is_readable(file)
arguments
  file (1,1) string
end

props = "Readable";
if isunix
  props = [props, "GroupRead", "OtherRead"];
end

try
  y = getPermissions(filePermissions(file), props);
catch e
  switch e.identifier
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      y = logical([]);
    otherwise
      rethrow(e)
  end
end

end
