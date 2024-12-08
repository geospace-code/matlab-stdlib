%% ISOCTAVE Detects if this is GNU Octave

function isoct = isoctave()

persistent o

if isempty(o)
  o = exist('OCTAVE_VERSION', 'builtin') == 5;
end

isoct = o;

end
