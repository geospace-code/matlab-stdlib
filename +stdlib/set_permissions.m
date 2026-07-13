%% SET_PERMISSIONS set path permissions
%
%%% Inputs
% * file
% * readable   (false remove read permission, true add read permission, empty no change)
% * writable   (false remove write permission, true add write permission, empty no change)
% * executable (false remove execute permission, true add execute permission, empty no change)
%%% Outputs
% * ok (1,1) logical

function ok = set_permissions(file, readable, writable, executable)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  readable logical {mustBeScalarOrEmpty} = []
  writable logical {mustBeScalarOrEmpty} = []
  executable logical {mustBeScalarOrEmpty} = []
end

p = filePermissions(file);

k = string.empty;
v = logical([]);

if ~isempty(readable)
  k(end+1) = "Readable";
  v(end+1) = readable;
end

if ~isempty(writable)
  k(end+1) = "Writable";
  v(end+1) = writable;
end

if ~isempty(executable)
  if ispc()
    if executable && ~ismember("Readable", k)
      k(end+1) = "Readable";
      v(end+1) = true;
    end
  else
    k(end+1) = "UserExecute";
    v(end+1) = executable;
  end
end

ok = true;

if ~isempty(k)
  setPermissions(p, k, v)
end

end
