%% hbackend pick a function to execute
% Given a string vector of "backend", check which backends are available.
% To save time, do not check that the function exists with which()


function [fun, m] = hbackend(backend, name)
arguments
  backend (1,:) string
  name (1,1) string
end

if ~strlength(backend)
  error("stdlib:hbackend:NameError", "backend is empty, which is not allowed")
elseif isscalar(backend)
  % bypass checks
  m = backend;
else
  m = switchyard(backend, name);
end

n = "stdlib." + m + "." + name;
fun = str2func(n);

end


function m = switchyard(backend, name)


for m = backend
  switch m
    case 'dotnet'
      has = @stdlib.has_dotnet;

      switch name
        case {'create_symlink', 'ram_total', 'read_symlink'}
          if stdlib.dotnet_api() < 6, continue, end
        case {'get_owner', 'is_admin'}
          if isunix(), continue, end
      end

    case "java"
      has = @stdlib.has_java;
      if endsWith(name, ["device", "hard_link_count", "inode", "is_admin"])
        if ispc(), continue, end
      end

    case 'python'

      has = @stdlib.has_python;

      switch name
        case {'filesystem_type', 'ram_total', 'ram_free'}
          if ~stdlib.python.has_psutil(); continue, end
        case {'cpu_load', 'get_owner'}
          if ispc(), continue, end
        case 'is_admin'
          if ispc() || stdlib.matlabOlderThan('R2024a'), continue, end
      end

    case 'legacy', has = true;

    case 'native'

      switch name
        case 'create_symlink'
          if isMATLABReleaseOlderThan('R2024b') || (ispc() && isMATLABReleaseOlderThan('R2025a'))
            continue
          end
        case {'is_symlink', 'read_symlink'}
          if isMATLABReleaseOlderThan('R2024b'), continue, end
        case {'get_permissions', 'set_permissions', 'is_exe', 'is_readable', 'is_writable'}
          if isMATLABReleaseOlderThan('R2025a'), continue, end
      end

      has = true;
    case 'sys'
      has = true;
    otherwise
      has = str2func("stdlib.has_" + m);
  end

  if has()
    return
  end
end

error("stdlib:hbackend:NameError", "Could not find any %s capable of running, using %s", name, join(backend, ','))

end
