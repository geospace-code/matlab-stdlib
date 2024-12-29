%% SUBPROCESS_RUN run process for Matlab only
% with optional cwd, env. vars, stdin, timeout
%
% handles command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%
%%% Inputs
% * cmd_array: vector of string to compose a command line
% * opt.env: environment variable struct to set
% * opt.cwd: working directory to use while running command
% * opt.stdin: string to pass to subprocess stdin pipe
% * opt.timeout: time to wait for process to complete before erroring (seconds)
%%% Outputs
% * status: 0 is generally success. -1 if timeout. Other codes as per the
% program / command run
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
%
% uses Matlab Java ProcessBuilder interface to run subprocess and use stdin/stdout pipes
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html

function [status, stdout, stderr] = subprocess_run(cmd, opt)
arguments
  cmd (1,:) string
  opt.env (1,1) struct = struct()
  opt.cwd (1,1) string = ""
  opt.stdin (1,1) string = ""
  opt.timeout (1,1) int64 = 0
end

%% process instantiation
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#command(java.lang.String...)
proc = java.lang.ProcessBuilder(cmd);

if ~isempty(fieldnames(opt.env))
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#environment()
  env = proc.environment();
  fields = fieldnames(opt.env);
  for i = 1:length(fields)
    env.put(fields{i}, opt.env.(fields{i}));
  end
end

if strlength(opt.cwd) > 0
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#directory(java.io.File)
  assert(isfolder(opt.cwd), "directory %s does not exist", opt.cwd)
  proc.directory(java.io.File(opt.cwd));
end
%% start process
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#start()
h = proc.start();

%% stdin pipe
if strlength(opt.stdin) > 0
  writer = java.io.BufferedWriter(java.io.OutputStreamWriter(h.getOutputStream()));
  writer.write(opt.stdin);
  writer.flush()
  writer.close()
end

%% wait for process to complete
% https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/lang/Process.html#waitFor()

tmsg = "";
if opt.timeout > 0
  % returns true if process completed successfully
  % returns false if process did not complete within timeout
  b = h.waitFor(opt.timeout, java.util.concurrent.TimeUnit.SECONDS);
  if b
    status = 0;
  else
    tmsg = "Subprocess timeout";
    status = -1;
  end
else
  % returns 0 if process completed successfully
  status = h.waitFor();
end

%% read stdout, stderr pipes
stdout = read_stream(h.getInputStream());
stderr = read_stream(h.getErrorStream());

%% close process
h.destroy()

stderr = tmsg + stderr;

if nargout < 2 && strlength(stdout) > 0
  disp(stdout)
end
if nargout < 3 && strlength(stderr) > 0
  warning(stderr)
end

end % function subprocess_run


function msg = read_stream(stream)

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/BufferedReader.html
reader = java.io.BufferedReader(java.io.InputStreamReader(stream));
line = reader.readLine();
msg = "";
while ~isempty(line)
  msg = append(msg, string(line), newline);
  line = reader.readLine();
end
msg = strip(msg);
reader.close()

end

%!testif 0
