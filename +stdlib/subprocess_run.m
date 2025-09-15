%% SUBPROCESS_RUN run process
%
% with optional cwd, env. vars, stdin, timeout
%
% handles command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%
%%% Inputs
% * cmd: command line. Windows paths should use filesep '\'
% * opt.env: environment variable struct to set
% * opt.cwd: working directory to use while running command
% * opt.stdin: string to pass to subprocess stdin pipe
% * opt.stdout: logical to indicate whether to use pipe for stdout
% * opt.stderr: logical to indicate whether to use pipe for stderr
%%% Outputs
% * status: 0 is generally success. Other codes as per the
% program / command run
% * msg: combined stdout and stderr from process
%
%% Example
% subprocess_run('mpiexec -help2');
% subprocess_run('sh -c "ls -l"');
% subprocess_run('cmd /c "dir /Q /L"');
%
% NOTE: if cwd option used, any paths must be absolute, or they are relative to pwd.

function [status, msg] = subprocess_run(cmd, opt)
arguments
  cmd (1,:) string
  opt.env (1,1) struct = struct()
  opt.cwd (1,1) string = ""
  opt.stdin (1,1) string = ""
  opt.stdout (1,1) logical = true
  opt.stderr (1,1) logical = true
  opt.echo (1,1) logical = false
end


if ~stdlib.strempty(opt.cwd)
  assert(isfolder(opt.cwd), opt.cwd + " is not a folder")

  cmd = join(["cd", opt.cwd, "&&", cmd]);
end

if ~stdlib.strempty(opt.stdin)
  cmd = join(["echo", opt.stdin, "|", cmd]);
end


if ~opt.stderr
  if ispc
    cmd = join([cmd, "2> nul"]);
  else
    cmd = join([cmd, "2> /dev/null"]);
  end
end

if ~opt.stdout
  if ispc
    cmd = join([cmd, "> nul"]);
  else
    cmd = join([cmd, "> /dev/null"]);
  end
end

% deal struct into name, value pairs for system()
f = fieldnames(opt.env);
env_pairs = cell(1, 2 * numel(f));
for i = 1:numel(f)
  env_pairs{2*i-1} = f{i};
  env_pairs{2*i} = opt.env.(f{i});
end

%% Gfortran streams
% https://www.mathworks.com/matlabcentral/answers/91919-why-does-the-output-of-my-fortran-script-not-show-up-in-the-matlab-command-window-when-i-execute-it#answer_101270
% Matlab grabs the stdout, stderr, stdin handles of a Gfortran program, even when it's using Java.
% We must disable this behavior for the duration the running process.

outold = getenv("GFORTRAN_STDOUT_UNIT");
setenv("GFORTRAN_STDOUT_UNIT", "6");
errold = getenv("GFORTRAN_STDERR_UNIT");
setenv("GFORTRAN_STDERR_UNIT", "0");
inold = getenv("GFORTRAN_STDIN_UNIT");
setenv("GFORTRAN_STDIN_UNIT", "5");

if opt.echo
  disp(cmd)
end

[status, msg] = system(join(cmd), env_pairs{:});

setenv("GFORTRAN_STDOUT_UNIT", outold);
setenv("GFORTRAN_STDERR_UNIT", errold);
setenv("GFORTRAN_STDIN_UNIT", inold);

msg = deblank(msg);

end
