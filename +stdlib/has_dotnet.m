%% HAS_DOTNET check if .NET is available
%
% .NET support in Matlab for macOS and Linux became available in R2025a.
% Ref: % https://www.mathworks.com/help/releases/R2024b/matlab/matlab_external/system-requirements-for-using-matlab-interface-to-net.html

function y = has_dotnet()
% The try-catch is for Matlab < R2022b as older Matlab can throw an error on unsupported .NET platforms.
try
  y = NET.isNETSupported;
catch
  y = false;
end

end
