%% SUBPROCESS_RUN_OCTAVE run process for GNU Octave only
% requires: java
%
% with optional cwd, env. vars, stdin, timeout
%
% handles command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%
%%% Inputs
% * cmd_array: cell of char to compose a command line
% * env: environment variable struct to set
% * cwd: working directory to use while running command
% * stdin: string to pass to subprocess stdin pipe
% * timeout: time to wait for process to complete before erroring (seconds)
%%% Outputs
% * status: 0 is generally success. -1 if timeout. Other codes as per the
% program / command run
% * stdout: stdout from process
% * stderr: stderr from process
%
%% Example
% subprocess_run({'mpiexec', '-help2'})
%
% NOTE: if cwd option used, any paths must be absolute or relative to cwd.
% otherwise, they are relative to pwd.
%
% uses Java ProcessBuilder interface to run subprocess and use stdin/stdout pipes
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html

function [status, stdout, stderr] = subprocess_run_octave(cmd, env, cwd, stdin, timeout)
if ischar(cmd), cmd = {cmd}; end
if nargin < 2 || isempty(env), env = struct(); end
if nargin < 3, cwd = ''; end
if nargin < 4, stdin = ''; end
if nargin < 5, timeout = 0; end

%% process instantiation
% https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/lang/ProcessBuilder.html#command(java.lang.String...)
jcary = javaArray("java.lang.String", length(cmd));
for i = 1:length(cmd)
  jcary(i) = javaObject("java.lang.String", cmd{i});
end
proc = javaObject("java.lang.ProcessBuilder", jcary);

if ~isempty(fieldnames(env))
  % https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/lang/ProcessBuilder.html#environment()
  jenv = proc.environment();
  fields = fieldnames(env);
  for i = 1:length(fields)
    jenv.put(fields{i}, env.(fields{i}));
    % jenv.put(fields{i}, javaObject("java.lang.String", env.(fields{i})));
  end
end

if stdlib.len(cwd) > 0
  % https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/lang/ProcessBuilder.html#directory(java.io.File)
  proc.directory(javaFileObject(cwd));
end

%% start process
% https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/lang/ProcessBuilder.html#start()
h = proc.start();

%% stdin pipe
if stdlib.len(stdin) > 0
  os = javaObject("java.io.OutputStream", h.getOutputStream());
  writer = javaObject("java.io.BufferedWriter", os);
  writer.write(stdin);
  writer.flush()
  writer.close()
end

%% wait for process to complete
% https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/lang/Process.html#waitFor()

tmsg = '';
if timeout > 0
  % returns true if process completed successfully
  % returns false if process did not complete within timeout
  sec = javaMethod("valueOf", "java.util.concurrent.TimeUnit", "SECONDS");
  b = h.waitFor(timeout, sec);
  if b
    status = 0;
  else
    tmsg = 'Subprocess timeout';
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
h.destroy();

stderr = strcat(tmsg, stderr);

if nargout < 2 && stdlib.len(stdout) > 0
  disp(stdout)
end
if nargout < 3 && stdlib.len(stderr) > 0
  warning(stderr)
end

end % function subprocess_run


function msg = read_stream(stream)

% https://docs.oracle.com/en/java/javase/23/docs/api/java.base/java/io/BufferedReader.html
reader = javaObject("java.io.BufferedReader", javaObject("java.io.InputStreamReader", stream));

line = reader.readLine();
msg = '';
while ~isempty(line)
  msg = strcat(msg, line, newline);

  line = reader.readLine();
end

if stdlib.len(msg) > 0 && msg(end) == newline
  msg(end) = [];
end

reader.close();

end

%!test
%! if ispc, c = "dir"; else, c = "ls"; end
%! [r, m, e] = subprocess_run_octave(c);
%! assert(r == 0)
%! assert(length(m) > 0)
%! assert(length(e) == 0)
%! [r, mc, e] = subprocess_run_octave(c, [], '/');
%! assert(r == 0)
%! assert(!strcmp(m, mc))
%!testif 0
%! names = {'TEST1', 'TEST2'};
%! vals = {'test123', 'test321'};
%! env = struct(names{1}, vals{1}, names{2}, vals{2});
%! for i = 1:length(names)
%!   if ispc
%!     c = {"cmd", "/c", "echo", strcat('%', names{i}, '%')};
%!   else
%!     c = {"echo", strcat('$', names{i})};
%!   end
%!   [r, m, e] = subprocess_run_octave(c, env);
%!   assert(r == 0)
%!   assert(strcmp(m, vals{i}), '%s != %s', m, vals{i})
%!   assert(length(e) == 0)
%! end
%!test
%! if ispc, c = {'powershell', '-command', 'Start-Sleep -s 3'}; else, c = {'sleep', '3'}; end
%! [r, m, e] = subprocess_run_octave(c, [], [], [], 1);
%! assert(r == -1)
%! assert(length(m) == 0)
%! assert(strncmp(e, 'Subprocess timeout', 17))
