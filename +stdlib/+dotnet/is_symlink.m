%% DOTNET.IS_SYMLINK check if a file is a symbolic link

function y = is_symlink(file)

if ~stdlib.exists(file)
  % necessary to avoid having to catch 'MATLAB:NET:CLRException:MethodInvoke' on Windows
  y = false;
  return
end
try
  if stdlib.dotnet.api() >= 6
    y = ~isempty(System.IO.FileInfo(file).LinkTarget);
  else
    attr = char(System.IO.File.GetAttributes(file).ToString());
    % https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes
    % ReparsePoint is for Linux, macOS, and Windows
    y = contains(attr, 'ReparsePoint');
  end
catch e
  y = dotnetException(e);
end

end
