function is_capable(tc, f)
arguments
  tc (1,1) matlab.unittest.TestCase
  f (1,1) function_handle
end

n = func2str(f);

if contains(n, ".dotnet.")

  dapi = stdlib.dotnet.api();
  tc.assumeGreaterThanOrEqual(dapi, 4, ".NET >= 4 not available")

elseif contains(n, ".java.")

  japi = stdlib.java.api();
  tc.assumeGreaterThanOrEqual(japi, 8, "Java >= 1.8 not available")

elseif contains(n, 'python')

  tc.assumeTrue(stdlib.has_python(), "Python not available")

end

end
