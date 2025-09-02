%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab
%
%%% inputs
% * file: path to symbolic link
% * backend: backend to use
%%% Outputs
% * r: target of symbolic link
% * b: backend used

function [r, b] = read_symlink(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end


if ismember('native', backend) || stdlib.strempty(backend)
  try
    [ok, r] = isSymbolicLink(file);
    r(~ok) = "";
    b = "native";
    return
  catch e
    if e.identifier ~= "MATLAB:UndefinedFunction"
      rethrow(e)
    end
  end

  backend(ismember(backend, 'native')) = [];
end

o = stdlib.Backend(mfilename(), backend);
b = o.backend;
r = o.func(file);

end
