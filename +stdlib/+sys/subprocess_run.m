function [status, msg] = subprocess_run(cmd_array, opt)
%% subprocess_run(cmd_array, opt)
% handle command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%%% Inputs
% * cmd_array: vector of string to compose a command line
% * opt.env: environment variable struct to set
% * opt.cwd: working directory to use while running command
%%% Outputs
% * status: 0 is success
% * msg: stderr + stdout from process
%
%% Example
% sys.subprocess_run(["mpiexec", "-help2"])
% sys.subprocess_run(["ls", "-l"])
% sys.subprocess_run(["dir", "/Q", "/L"])
%
% NOTE: if cwd option used, any paths must be absolute or relative to cwd.
% otherwise, they are relative to pwd.

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

old = verLessThan('matlab', '9.13');
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
