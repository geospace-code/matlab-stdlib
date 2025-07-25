function i = device(path)

% this has been not so stable, so we disabled it and leave it here for reference.

i = [];

h = NET.addAssembly('System.Management');

r = stdlib.root_name(path);
queryLogicalDisk = sprintf('SELECT VolumeSerialNumber FROM Win32_LogicalDisk WHERE Caption = ''%s''', r);

% Create a ManagementObjectSearcher instance
searcher = System.Management.ManagementObjectSearcher(queryLogicalDisk);

% Get the collection of ManagementObject instances
logicalDisks = searcher.Get();

% Get the first result (should be at most one for a drive letter)
logicalDiskEnumerator = logicalDisks.GetEnumerator();
if logicalDiskEnumerator.MoveNext()
  logicalDisk = logicalDiskEnumerator.Current;

  % Get the VolumeSerialNumber property
  % This property is a string in WMI, representing a 32-bit hexadecimal integer.
  i = hex2dec(char(logicalDisk.GetPropertyValue('VolumeSerialNumber')));
end

delete(h)

end
