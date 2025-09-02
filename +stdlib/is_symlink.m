%% IS_SYMLINK is path a symbolic link
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * ok: true if path is a symbolic link
% * b: backend used

function [ok, b] = is_symlink(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "java", "python", "dotnet", "sys"]
end

if ismember('native', backend) || stdlib.strempty(backend)
  try
    ok = isSymbolicLink(file);
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
ok = o.func(file);

end
