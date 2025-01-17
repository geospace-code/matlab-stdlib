%% IS_WSL detect if running under WSL (optional MEX)
% Detects if Matlab or GNU Octave is installed and running from within
% Windows Subsystem for Linux

function w = is_wsl()

w = 0;

if isunix && ~ismac
  fid = fopen('/proc/version');
  if fid >= 1
    v = fscanf(fid, '%s');
    if fclose(fid) ~= 0
      w = -1;
    elseif endsWith(v, "microsoft-standard-WSL2")
      w = 2;
    elseif endsWith(v, "-Microsoft")
      w = 1;
    end
  end
end

w = int32(w);

end

%!assert(class(is_wsl()), "int32")
