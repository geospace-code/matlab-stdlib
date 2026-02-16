% JAVA.CPU_ARCH
% diagnostic to see what Java says its arch is
% useful for diagnosing Java issues vis-a-vis Matlab or Octave

function a = cpu_arch()

a = char(javaMethod('getProperty', 'java.lang.System', 'os.arch'));

end