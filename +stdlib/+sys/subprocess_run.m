function [status, stdout, stderr] = subprocess_run(cmd, opt)
% SUBPROCESS_RUN run a program with arguments and options
% uses Matlab Java ProcessBuilder interface to run subprocess and use stdin/stdout pipes
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html
arguments
  cmd (1,:) string
  opt.env struct {mustBeScalarOrEmpty} = struct.empty
  opt.cwd string {mustBeScalarOrEmpty} = string.empty
  opt.stdin string {mustBeScalarOrEmpty} = string.empty
end

%% process instantiation
proc = java.lang.ProcessBuilder("");

if ~isempty(opt.env)
  % requires Parallel Computing Toolbox
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#environment()
  env = proc.environment();
  fields = fieldnames(opt.env);
  for i = 1:length(fields)
    env.put(fields{i}, opt.env.(fields{i}));
  end
end

if ~isempty(opt.cwd)
  mustBeFolder(opt.cwd)
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#directory(java.io.File)
  proc.directory(java.io.File(opt.cwd));
end

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#command(java.lang.String...)
proc.command(cmd);
%% start process
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ProcessBuilder.html#start()
h = proc.start();

%% stdin pipe
if ~isempty(opt.stdin)
  writer = java.io.BufferedWriter(java.io.OutputStreamWriter(h.getOutputStream()));
  writer.write(opt.stdin);
  writer.flush()
  writer.close()
end

%% wait for process to complete
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Process.html#waitFor()
status = h.waitFor();

%% read stdout, stderr pipes
stdout = read_stream(h.getInputStream());
stderr = read_stream(h.getErrorStream());

%% close process
h.destroy()

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
