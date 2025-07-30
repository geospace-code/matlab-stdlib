function is_capable(tc, f)
arguments
  tc (1,1) matlab.unittest.TestCase
  f (1,1) function_handle
end

n = func2str(f);

if contains(n, ".dotnet.")

  dapi = stdlib.dotnet_api();

  tc.assumeGreaterThan(dapi, 0, ".NET not available")

  if endsWith(n, ["is_admin", "owner"])
    tc.assumeTrue(ispc(), "Windows only function")
  end

  if endsWith(n, ["create_symlink", "ram_total", "read_symlink"])
    tc.assumeGreaterThanOrEqual(dapi, 6);
  end

elseif contains(n, ".java.")

  japi = stdlib.java_api();
  tc.assumeGreaterThan(japi, 0, "Java not available")

  if endsWith(n, ["device", "inode","is_admin"])
    tc.assumeTrue(isunix())
  end

elseif contains(n, "python")

   tc.assumeTrue(stdlib.has_python(), "Python not available")

   if endsWith(n, ["filesystem_type", "ram_free", "ram_total"])
     tc.assumeTrue(stdlib.python.has_psutil(), "need Python psutil package")
   end

   if endsWith(n, "owner")
     tc.assumeFalse(ispc(), "unix only function")
   end

   if endsWith(n, "is_admin")
     tc.assumeTrue(isunix() || ~isMATLABReleaseOlderThan('R2024a'))
   end

elseif contains(n, ".sys.")

  if endsWith(n, "samepath")
    tc.assumeTrue(isunix(), "unix only function")
  end

elseif contains(n, ".native.")

  if endsWith(n, ["is_exe", "set_permissions"])
    tc.assumeFalse(isMATLABReleaseOlderThan('R2025a'))
  end

  if endsWith(n, "canonical")
    tc.assumeFalse(isMATLABReleaseOlderThan('R2024a'))
  end

end

end
