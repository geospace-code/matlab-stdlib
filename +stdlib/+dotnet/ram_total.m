%% DOTNET.RAM_TOTAL get total physical RAM

function bytes = ram_total()
  % .NET is 2-3x faster than Java for this
  % https://learn.microsoft.com/en-us/dotnet/api/system.gcmemoryinfo.totalavailablememorybytes
try
  bytes = System.GC.GetGCMemoryInfo().TotalAvailableMemoryBytes;
catch
  bytes = [];
end

bytes = uint64(bytes);
end
