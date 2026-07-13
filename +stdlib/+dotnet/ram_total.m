%% DOTNET.RAM_TOTAL get total physical RAM
% .NET >= 5

function bytes = ram_total()
% .NET is 2-3x faster than Java for this
% https://learn.microsoft.com/en-us/dotnet/api/system.gcmemoryinfo.totalavailablememorybytes

bytes = System.GC.GetGCMemoryInfo().TotalAvailableMemoryBytes;
bytes = uint64(bytes);

end
