%% DEVICE filesystem device index of path
% optional: java

function i = device(path)
arguments
  path {mustBeTextScalar}
end

i = [];

if ispc()
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
elseif stdlib.isoctave()
  [s, err] = stat(path);
  if err == 0
    i = s.dev;
  end
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  i = java.nio.file.Files.getAttribute(javaPathObject(path), "unix:dev", javaLinkOption());
end

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
