function [status, stdout, stderr] = subprocess_run(cmd_array, opt)
%% subprocess_run(cmd_array, opt)
% handle command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%%% Inputs
% * cmd_array: vector of string to compose a command line
% * opt.env: environment variable struct to set
% * opt.cwd: working directory to use while running command
% * opt.stdin: string to pass to subprocess stdin pipe
%%% Outputs
% * status: 0 is success
% * stdout: stdout from process
% * stderr: stderr from process
%
%% Example
% subprocess_run(["mpiexec", "-help2"])
% subprocess_run(["sh", "-c", "ls", "-l"])
% subprocess_run(["cmd", "/c", "dir", "/Q", "/L"])
%
% NOTE: if cwd option used, any paths must be absolute or relative to cwd.
% otherwise, they are relative to pwd.

arguments
  cmd_array (1,:) string
  opt.env struct {mustBeScalarOrEmpty} = struct.empty
  opt.cwd string {mustBeScalarOrEmpty} = string.empty
  opt.stdin string {mustBeScalarOrEmpty} = string.empty
end

[status, stdout, stderr] = stdlib.sys.subprocess_run(cmd_array, ...
'env', opt.env, 'cwd', opt.cwd, "stdin", opt.stdin);

if nargout<3
  fprintf(2, stderr)
end

if nargout<2
  disp(stdout)
end

end
