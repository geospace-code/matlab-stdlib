%% hbackend pick a function to execute
% Given a string vector of "backend", check which backends are available.
% To save time, do not check that the function exists with which()


function [fun, m] = hbackend(backend, name, minVersion)
arguments
  backend (1,:) string
  name (1,1) string
  minVersion {mustBeTextScalar} = ''
end

for m = backend
  switch m
    case "dotnet"
      has = @stdlib.has_dotnet;

      if endsWith(name, ["create_symlink", "ram_total", "read_symlink"])
        if stdlib.dotnet_api() < 6, continue, end
      end

      if endsWith(name, ["get_owner", "is_admin"])
        if ~ispc(), continue, end
      end

    case "java"

      has = @stdlib.has_java;
      if endsWith(name, ["device", "hard_link_count", "inode", "is_admin"])
        if ~isunix(), continue, end
      end

    case "python"

      has = @stdlib.has_python;

      if endsWith(name, ["filesystem_type", "ram_total", "ram_free"])
        if ~stdlib.python.has_psutil(); continue, end
      end

      if endsWith(name, ["cpu_load", "get_owner"])
        if ~isunix(), continue, end
      end

      if endsWith(name, "is_admin")
        if ~isunix() || isMATLABReleaseOlderThan('R2024a'), continue, end
      end

    case "legacy", has = true;

    case "native"

      has = stdlib.strempty(minVersion) || ~isMATLABReleaseOlderThan(minVersion);

      if endsWith(name, "create_symlink")
        if ~has || ispc(), continue, end
      end

    case "sys"

      has = true;

      if endsWith(name, ["is_char_device", "samepath"])
        if ispc(), continue, end
      end

    otherwise
      has = str2func("stdlib.has_" + m);
  end

  if has()
    n = "stdlib." + m + "." + name;
    fun = str2func(n);
    return
  end
end

error("stdlib:hbackend:NameError", "Could not find any %s capable of running, using %s", name, join(backend, ','))

end
