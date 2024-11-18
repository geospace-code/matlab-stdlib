function yeswsl = iswsl()
%% ISWSL detect if running under WSL
% Detects if Matlab or GNU Octave is installed and running from within
% Windows Subsystem for Linux
persistent wsl;

if isempty(wsl)
  wsl = false;
  if isunix && ~ismac
    fid = fopen('/proc/version');
    if fid >= 1
      v = fscanf(fid,'%s');
      fclose(fid);
      wsl = contains(v, 'microsoft-standard');
    end
  end
end

yeswsl=wsl; % has to be a separate line/variable for matlab

end
