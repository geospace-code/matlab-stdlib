function dotnetException(e)

switch class(e)
  case 'MException'
    switch e.identifier
      case {'MATLAB:NET:NetConversion:StringConversion'}
      otherwise, rethrow(e)
    end
  case 'NET.NetException'
    switch class(e.ExceptionObject)
      case {'System.IO.DriveNotFoundException', 'System.IO.FileNotFoundException', 'System.ArgumentException'}
      otherwise, rethrow(e)
    end
end

end