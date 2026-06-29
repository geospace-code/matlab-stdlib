function build_exe(context)

for i = 1:length(context.Task.Inputs)
  src = context.Task.Inputs(i);
  exe = context.Task.Outputs(i).paths;

  % need this for paths with spaces
  source_file = '"' + src.paths + '"';
  exe = '"' + exe(1) + '"';

  ext = stdlib.suffix(src.paths);
  switch ext
    case ".c", lang = "c";
    case ".cpp", lang = "c++";
    case ".f90", lang = "fortran";
    otherwise, error("unknown code suffix " + ext)
  end

  [comp, shell, outFlag] = get_build_cmd(lang);
  if isempty(comp)
    return
  end
  if i == 1 && ~isempty(shell)
    disp("Shell: " + shell)
  end



  cmd = join([comp, source_file, outFlag + exe]);
  if ~isempty(shell)
    cmd = join([shell, stdlib.cmdsep(), cmd]);
  end

  disp(cmd)
  [s, msg] = system(cmd);
  assert(s == 0, "Error %d: %s", s, msg)
end

end
