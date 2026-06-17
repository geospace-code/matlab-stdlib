%% SHELL.CPU_ARCH
% invoke a shell to get CPU arch. This can sometimes workaround limitations
% of emulation e.g. Prism emulation on Windows.
% This is heuristic and not guaranteed to work.
% We invoke a shell to try to workaround the Matlab application masking the CPU.

function [a, cmd] = cpu_arch()

if ispc()
  % cmd /c echo %PROCESSOR_ARCHITECTURE% doesn't help, but pwsh -c does.
  cmd = 'pwsh -c "echo $Env:PROCESSOR_ARCHITECTURE"';
else
  cmd = 'sh -c uname -m';
end

[s, r] = system(cmd);

if s == 0
  a = deblank(r);
else
  warning('stdlib:shell:cpu_arch:RuntimeError', 'Failed to execute command "%s": %s', cmd, r);
  a = '';
end

end
