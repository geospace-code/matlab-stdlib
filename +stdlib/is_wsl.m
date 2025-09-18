%% IS_WSL detect if running under WSL
%
% Detects if Matlab is installed and running from within
% Windows Subsystem for Linux

function w = is_wsl()

w = 0;

if isunix() && ~ismac()
  fid = fopen('/proc/version');
  if fid >= 1
    v = fscanf(fid, '%s');
    fclose(fid);
    if endsWith(v, 'microsoft-standard-WSL2')
      w = 2;
    elseif endsWith(v, '-Microsoft')
      w = 1;
    end
  end
end

end

%!test
%! mustBeInteger(stdlib.is_wsl())
