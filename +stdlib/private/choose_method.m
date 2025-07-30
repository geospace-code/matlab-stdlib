%% CHOOSE_METHOD pick a function to execute
% Given a string vector of "method", check which methods are available.
% To save time, do not check that the function exists with which()


function fun = choose_method(method, name, minVersion)
arguments
  method (1,:) string
  name (1,1) string
  minVersion {mustBeTextScalar} = ''
end

for m = method
  switch m
    case "dotnet"
      has = @stdlib.has_dotnet;

      if endsWith(name, "ram_total")
        if stdlib.dotnet_api() < 6, continue, end
      end
    case "java"
      has = @stdlib.has_java;
      if endsWith(name, ["device", "hard_link_count", "inode"])
        if ~isunix(), continue, end
      end
    case "python"
      has = @stdlib.has_python;

      if endsWith(name, ["filesystem_type", "ram_total", "ram_free"])
        if ~stdlib.python.has_psutil(); continue, end
      end
    case {"legacy", "sys"}, has = true;
    case "native", has = stdlib.strempty(minVersion) || ~isMATLABReleaseOlderThan(minVersion);
    otherwise
      has = str2func("stdlib.has_" + m);
  end

  if has()
    n = "stdlib." + m + "." + name;
    fun = str2func(n);
    return
  end
end

error("stdlib:choose_method:NameError", "Could not find any %s capable of running, using %s", name, join(method, ','))

end
