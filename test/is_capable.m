function is_capable(tc, f)
arguments
  tc (1,1) matlab.unittest.TestCase
  f (1,1) function_handle
end

n = func2str(f);

if contains(n, ".dotnet.")

  dapi = stdlib.dotnet_api();
  tc.assumeGreaterThan(dapi, 0, ".NET not available")

elseif contains(n, ".java.")

  japi = stdlib.java_api();
  tc.assumeGreaterThan(japi, 0, "Java not available")

elseif contains(n, 'python')

  tc.assumeTrue(stdlib.has_python(), "Python not available")

end

end
