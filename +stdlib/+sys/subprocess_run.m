function [status, msg] = subprocess_run(cmd_array, opt)

arguments
  cmd_array (1,:) string
  opt.env struct {mustBeScalarOrEmpty} = struct.empty
  opt.cwd string {mustBeScalarOrEmpty} = string.empty
end

exe = space_quote(cmd_array(1));

if length(cmd_array) > 1
  cmd = append(exe, " ", join(cmd_array(2:end), " "));
else
  cmd = exe;
end

if ~isempty(opt.cwd)
  cwd = stdlib.fileio.absolute_path(opt.cwd);
  assert(isfolder(cwd), "subprocess_run: %s is not a folder", cwd)
  oldcwd = pwd;
  cd(cwd)
end

old = isMATLABReleaseOlderThan('R2022b');
if old && ~isempty(opt.env)
  warning("Matlab >= R2022b required for 'env' option of subprocess_run()")
end

if isempty(opt.env) || old
  [status, msg] = system(cmd);
else
  envCell = namedargs2cell(opt.env);

  [status, msg] = system(cmd, envCell{:});
end
if ~isempty(opt.cwd)
  cd(oldcwd)
end

end


function q = space_quote(p)
arguments
  p (1,1) string
end

if ~contains(p, " ")
  q = p;
  return
end

q = append('"', p, '"');

end
