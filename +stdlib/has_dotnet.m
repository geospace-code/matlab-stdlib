%% HAS_DOTNET check if .NET is available
%
% .NET support in Matlab for macOS and Linux became available in R2025a.
% Ref: % https://www.mathworks.com/help/releases/R2024b/matlab/matlab_external/system-requirements-for-using-matlab-interface-to-net.html

function y = has_dotnet()

try
  y = NET.isNETSupported;
catch
  try
    y = stdlib.dotnet_api() >= 4;
  catch
    y = false;
  end
end

end
