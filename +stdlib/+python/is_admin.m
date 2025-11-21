function y = is_admin()

y = logical([]);

try

if isunix()
  y = py.os.getuid() == 0;
elseif ~stdlib.matlabOlderThan('R2024a')
  shell32 = py.ctypes.WinDLL('shell32');

  % this is a key step vs. simply py.ctypes.windll.shell32.IsUserAnAdmin()
  f = py.getattr(shell32, 'IsUserAnAdmin');

  y = logical(f());
end

catch e
  pythonException(e)
end

end
