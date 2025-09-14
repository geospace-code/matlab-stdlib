function y = is_writable(file)
arguments
  file (1,1) string
end

props = "Writable";
if isunix
  props = [props, "GroupWrite", "OtherWrite"];
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
