%% HAS_DOTNET check if .NET is available
%
% .NET support in Matlab for macOS and Linux became available in R2025a.
% Ref: % https://www.mathworks.com/help/releases/R2024b/matlab/matlab_external/system-requirements-for-using-matlab-interface-to-net.html

function y = has_dotnet()

y = false;

if stdlib.isoctave, return, end

if ~ispc() && isMATLABReleaseOlderThan('R2024b'), return, end

y = NET.isNETSupported;

end
