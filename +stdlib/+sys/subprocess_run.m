function [status, msg] = subprocess_run(cmd_array, opt)
% handle command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%
% example:
% sys.subprocess_run(["mpiexec", "-help2"])
% sys.subprocess_run(["ls", "-l"])
% sys.subprocess_run(["dir", "/Q", "/L"])
%
% NOTE: if cwd option used, any paths must be absolute or relative to cwd.
% otherwise, they are relative to pwd.

arguments
  cmd_array (1,:) string
  opt.env (1,1) struct = struct()
  opt.cwd string {mustBeScalarOrEmpty} = string.empty
end

import stdlib.fileio.absolute_path

exe = space_quote(cmd_array(1));

if length(cmd_array) > 1
  cmd = append(exe, " ", join(cmd_array(2:end), " "));
else
  cmd = exe;
end

if ~isempty(fieldnames(opt.env))
  for f = string(fieldnames(opt.env)).'
    if ispc
      cmd = append("set ", f, "=", opt.env.(f), " && ", cmd);
    else
      cmd = append(f, "=", opt.env.(f), " ", cmd);
    end
  end
end

if ~isempty(opt.cwd)
  cwd = absolute_path(opt.cwd);
  assert(isfolder(cwd), "subprocess_run: %s is not a folder", cwd)
  oldcwd = pwd;
  cd(cwd)
end

[status, msg] = system(cmd);

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
