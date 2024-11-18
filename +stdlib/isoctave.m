function isoct = isoctave()
%% ISOCTAVE Detects if this is GNU Octave

isoct = exist('OCTAVE_VERSION', 'builtin') == 5;

end
