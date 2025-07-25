function bytes = ram_total()
  % .NET is 2-3x faster than Java for this
  % https://learn.microsoft.com/en-us/dotnet/api/system.gcmemoryinfo.totalavailablememorybytes
  bytes = uint64(System.GC.GetGCMemoryInfo().TotalAvailableMemoryBytes);
end
