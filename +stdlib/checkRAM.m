%% CHECKRAM estimate if RAM will fit a new array
% checks that requested memory for the new array won't exceed AVAILABLE RAM with Matlab
%
% This script is optimistic as Matlab won't always be able to
% create an array using ALL available RAM, but at least you know when you
% certainly CAN'T create an array without digging deep into swap or worse.

function [OK,newSizeBytes,freebytes] = checkRAM(newSize, myclass)
arguments
  newSize (1,:) {mustBeNumeric}
  myclass {mustBeTextScalar}
end

% get available RAM
freebytes = stdlib.ram_free();

% get user set preference for memory limit
s = settings;
ws = s.matlab.desktop.workspace;

% Check if the maximum array size limit is enabled
if ws.ArraySizeLimitEnabled.ActiveValue
  limit_bytes = double(ws.ArraySizeLimit.ActiveValue) / 100 * stdlib.ram_total();
else
  limit_bytes = inf; % no limit set
end

limit_bytes = min(limit_bytes, freebytes);

% variable sizing
switch(myclass)
  case 'complex single', bits = 64;
  case 'complex double', bits = 128;
  case {'single','int32','uint32'}, bits = 32;
  case {'double','int64','uint64','float'}, bits = 64;
  case {'int16','uint16'}, bits = 16;
  case {'int8','uint8'}, bits = 8;
  case {'logical','bool'}, bits = 1;
  case {'string','char'}, bits = 8;
  otherwise, error('unhandled variable class: %s', myclass)
end

newSizeBytes = prod(newSize)*bits / 8;

OK = newSizeBytes < limit_bytes;

end

%!assert(checkRAM([15,2,1], 'double'), true)
