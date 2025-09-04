%% BACKEND auto-selection of function backend per-function
% the user can specify a backend, or else this class automatically
% determines suitable backends for the system.
%
% * 'sys' is usually the slowest, but most compatible.
% * 'python' or 'dotnet' are among the fastest, but not always available
% * 'java' and 'perl' are usually available and medium speed
% * 'native' uses the latest Matlab syntax available
% * 'legacy' is Matlab syntax for older Matlab versions. Sometimes legacy is faster than native, but native is more robust/general.

classdef Backend < matlab.mixin.SetGet

properties (Constant)
optionalBackends = ["java", "perl", "python", "dotnet"]
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

if isempty(backendReq) || ~isscalar(backendReq)
  for i = 1:numel(self.optionalBackends)
    f = str2func(sprintf('%s.has_%s', self.namespace, self.optionalBackends(i)));
    if f()
      self.backends = [self.optionalBackends(i), self.backends];
    end
  end
end

if strlength(functionName)
  self.func = self.getFunc(functionName, backendReq);
end

end


function backendAvailable = select(self, functionName, backendReq, firstOnly)
arguments
  self
  functionName (1,1) string
  backendReq (1,:) string = string.empty
  firstOnly (1,1) logical = false
end

backendAvailable = string.empty;

if ~any(strlength(backendReq))
  backendReq = self.backends;
end

for m = backendReq
  switch m
    case 'dotnet'
      if ~ismember('dotnet', self.backends)
        continue
      end

      switch functionName
        case {'create_symlink', 'ram_total', 'read_symlink'}
          if stdlib.dotnet_api() < 6, continue, end
        case {'get_owner', 'get_uid', 'is_admin'}
          if isunix(), continue, end
      end
    case 'java'
      if ~ismember('java', self.backends)
        continue
      end

      switch functionName
        case {'device', 'hard_link_count' , 'inode', 'is_admin'}
          if ispc(), continue, end
      end
    case 'perl'
      switch functionName
        case {'get_uid'}
          if ispc(), continue, end
      end
    case 'python'
      if ~ismember('python', self.backends)
        continue
      end

      switch functionName
        case {'filesystem_type', 'is_removable', 'ram_total', 'ram_free'}
          if ~stdlib.python.has_psutil(); continue, end
        case {'cpu_load', 'get_owner', 'get_process_priority', 'get_uid'}
          if ispc(), continue, end
        case 'is_admin'
          if ispc() || stdlib.matlabOlderThan('R2024a'), continue, end
        case 'is_dev_drive'
          pyv = stdlib.python_version();
          if any(pyv(1:2) < [3, 12]), continue, end
      end
    case 'native'

      switch functionName
        case 'create_symlink'
          % Some Windows R2025a give error 'MATLAB:io:filesystem:symlink:NeedsAdminPerms'
          % 25.1.0.2973910 (R2025a) Update 1 gave this error for example.
          if stdlib.matlabOlderThan('R2024b') || ispc()
            continue
          end
        case {'is_symlink', 'read_symlink'}
          if stdlib.matlabOlderThan('R2024b'), continue, end
      end
  end

  if ~isempty(which(sprintf('%s.%s.%s', self.namespace, m, functionName)))
    backendAvailable(end+1) = m; %#ok<AGROW>
    if firstOnly
      return
    end
  end

end

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
  self.backend = self.select(functionName, backendReq, true);
end

if isempty(self.backend)
  error('No backend found for %s.%s', self.namespace, functionName);
else
  func = str2func(sprintf('%s.%s.%s', self.namespace, self.backend, functionName));
end

end

end
end
