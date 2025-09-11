function dotnetException(e)

switch class(e)
  case 'MException'
    switch e.identifier
      case {'MATLAB:NET:NetConversion:StringConversion'}
        % pass
      case {'MATLAB:undefinedVarOrClass', 'MATLAB:NET:NETInterfaceUnsupported'}
        % .NET not enabled
      case {'MATLAB:NET:INVALIDMEMBER', 'MATLAB:subscripting:classHasNoPropertyOrMethod', 'MATLAB:NET:CLRException:MethodInvoke'}
        % .NET too old or not supported on this platform
      otherwise
        rethrow(e)
    end
  case 'NET.NetException'
    switch class(e.ExceptionObject)
      case {'System.IO.DriveNotFoundException', 'System.IO.FileNotFoundException', 'System.ArgumentException'}
        % pass
      otherwise
        rethrow(e)
    end
end

end
