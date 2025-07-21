%% HAS_DOTNET check if .NET is available
function tf = has_dotnet()

tf = ~isMATLABReleaseOlderThan('R2023a') && NET.isNETSupported;

end
