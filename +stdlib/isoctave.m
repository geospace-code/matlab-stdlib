%% ISOCTAVE Detects if this is GNU Octave

function isoct = isoctave()
isoct = exist('OCTAVE_VERSION', 'builtin') == 5;
end
