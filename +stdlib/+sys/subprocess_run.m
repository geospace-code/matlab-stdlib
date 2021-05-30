function [status, msg] = subprocess_run(cmd_array, env)
% handle command lines with spaces
% input each segment of the command as an element in a string array
% this is how python subprocess.run works
%
% example:
% sys.subprocess_run(["mpiexec", "-help2"])
% sys.subprocess_run(["ls", "-l"])
% sys.subprocess_run(["dir", "/Q", "/L"])

arguments
  cmd_array (1,:) string
  env (1,1) struct = struct()
end

exe = space_quote(cmd_array(1));

if length(cmd_array) > 1
  cmd = append(exe, " ", join(cmd_array(2:end), " "));
else
  cmd = exe;
end

if ~isempty(fieldnames(env))
  for f = string(fieldnames(env)).'
    if ispc
      cmd = append("set ", f, "=", env.(f), " && ", cmd);
    else
      cmd = append(f, "=", env.(f), " ", cmd);
    end
  end
end

[status, msg] = system(cmd);

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
