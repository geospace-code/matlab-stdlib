%% IS_WSL detect if running under WSL
% Detects if Matlab or GNU Octave is installed and running from within
% Windows Subsystem for Linux

function w = is_wsl()

persistent wsl;

if isempty(wsl)
  wsl = false;
  if isunix && ~ismac
    fid = fopen('/proc/version');
    if fid >= 1
      v = fscanf(fid,'%s');
      fclose(fid);
      wsl = ~isempty(strfind(v, 'microsoft-standard')); %#ok<*STREMP>
    end
  end
end

w = wsl; % has to be a separate line/variable for matlab

end

%!assert(islogical(is_wsl()))
