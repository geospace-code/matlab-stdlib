classdef Backend < matlab.mixin.SetGet

properties (Constant)
optionalBackends = ["python", "dotnet", "java"]
namespace = "stdlib"
end

properties
backends string = ["native", "legacy", "sys"]
func
backend
end

methods

function self = Backend(functionName, backendReq)
arguments
  functionName (1,1) string = ""
  backendReq (1,:) string = string.empty
end

for i = 1:numel(self.optionalBackends)
  f = str2func(sprintf('%s.has_%s', self.namespace, self.optionalBackends(i)));
  if f()
    self.backends = [self.optionalBackends(i), self.backends];
  end
end

if any(strlength(functionName))
  self.func = self.getFunc(functionName, backendReq);
end
end


function m = select(self, functionName, backendReq)
arguments
  self
  functionName (1,1) string
  backendReq (1,:) string = string.empty
end

if ~any(strlength(backendReq))
  backendReq = self.backends;
end

for m = backendReq
  switch m
    case 'dotnet'
      if ~any(ismember(self.backends, 'dotnet'))
        continue
      end

      switch functionName
        case {'create_symlink', 'ram_total', 'read_symlink'}
          if stdlib.dotnet_api() < 6, continue, end
        case {'get_owner', 'is_admin'}
          if isunix(), continue, end
      end
    case 'java'
      if ~any(ismember(self.backends, 'java'))
        continue
      end

      switch functionName
        case {'device', 'hard_link_count' , 'inode', 'is_admin'}
          if ispc(), continue, end
      end
    case 'python'
      if ~any(ismember(self.backends, 'python'))
        continue
      end

      switch functionName
        case {'filesystem_type', 'ram_total', 'ram_free'}
          if ~stdlib.python.has_psutil(); continue, end
        case {'cpu_load', 'get_owner'}
          if ispc(), continue, end
        case 'is_admin'
          if ispc() || stdlib.matlabOlderThan('R2024a'), continue, end
      end
    case 'native'

      switch functionName
        case 'create_symlink'
          if stdlib.matlabOlderThan('R2024b') || (ispc() && stdlib.matlabOlderThan('R2025a'))
            continue
          end
        case {'is_symlink', 'read_symlink'}
          if stdlib.matlabOlderThan('R2024b'), continue, end
        case {'get_permissions', 'set_permissions'}
          if stdlib.matlabOlderThan('R2025a'), continue, end
      end
  end

  if ~isempty(which(sprintf('%s.%s.%s', self.namespace, m, functionName)))
    return
  end

end

m = string.empty;

end


function func = getFunc(self, functionName, backendReq)
arguments
  self
  functionName (1,1) string
  backendReq (1,:) string = string.empty
end

if isscalar(backendReq)
  self.backend = backendReq;
else
  self.backend = self.select(functionName, backendReq);
end

if isempty(self.backend)
  error('No backend found for %s.%s', self.namespace, functionName);
else
  func = str2func(sprintf('%s.%s.%s', self.namespace, self.backend, functionName));
end

end

end
end
