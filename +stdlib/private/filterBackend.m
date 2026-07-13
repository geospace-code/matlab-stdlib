function backend = filterBackend(backend, funcName)
arguments
  backend (1,:) string
  funcName {mustBeTextScalar} = ''
end
%FILTERBACKENDS Filter backends
%   backend = filterBackends(backend) filters the input backend list to remove
%   backends that are not supported. If the input
%   backend list is empty, the output will also be empty.

if any(contains(backend, "native"))
  switch funcName
    case {'create_symlink', 'is_symlink', 'read_symlink'}
      no = stdlib.matlabOlderThan('R2024b');
    otherwise
      no = false;
  end

  if no
    backend = backend(backend ~= "native");
  end
end

if any(contains(backend, "python"))

  no = stdlib.matlabOlderThan('R2022a') || ~stdlib.has_python();
  if ~no
    switch funcName
      case {'cpu_load', 'get_max_open_files', 'get_owner', 'get_process_priority', 'get_uid'}
        no = ispc();
      case {'filesystem_type', 'is_removable', 'ram_free', 'ram_total', 'uptime'}
        no = ~stdlib.python.has_psutil();
      case 'is_admin'
        if ispc()
          no = stdlib.matlabOlderThan('R2024a');
        end
      case 'is_dev_drive'
        pyv = stdlib.python.version();
        no = any(pyv(1:2) < [3, 12]);
    end
  end

  if no
    backend = backend(backend ~= "python");
  end

end


if any(contains(backend, "dotnet"))
  no = ~stdlib.has_dotnet();
  if ~no
    switch funcName
      case {'create_symlink', 'read_symlink'}
        no = stdlib.dotnet.api() < 6;
      case {'get_owner', 'get_uid', 'is_admin'}
        no = ~ispc();
      case {'ram_total', 'uptime'}
        no = stdlib.dotnet.api() < 5;
    end
  end

  if no
    backend = backend(backend ~= "dotnet");
  end
end


if any(contains(backend, "java"))
  no = ~stdlib.has_java();

  if ~no
    switch funcName
      case {'device', 'hard_link_count', 'inode', 'is_admin'}
        no = ispc();
    end
  end

  if no
    backend = backend(backend ~= "java");
  end
end

end
