%% DOTNET.IS_SYMLINK check if a file is a symbolic link

function y = is_symlink(p)

try
  if stdlib.dotnet_api() >= 6
    y = ~isempty(System.IO.FileInfo(p).LinkTarget);
  else
    attr = string(System.IO.File.GetAttributes(p).ToString());
    % https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes
    % ReparsePoint is for Linux, macOS, and Windows
    y = contains(attr, 'ReparsePoint');
  end
catch e
  switch e.identifier
    case {'MATLAB:NET:CLRException:CreateObject', 'MATLAB:NET:CLRException:MethodInvoke'}
      y = false;
    otherwise, rethrow(e)
  end
end

end
