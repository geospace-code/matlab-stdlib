%% GET_PUBLIC_IPADDR - Get public IP address
function result = get_public_ipaddr()
% Returns a struct with .ipv6 and .ip fields

import matlab.net.*
import matlab.net.http.*

endpoints = [
  struct(name='ipify6', url="https://api6.ipify.org?format=json"), ...
  struct(name='ident',  url="https://ident.me/json"), ...
  struct(name='ipify4', url="https://api.ipify.org?format=json")
  ];

result = struct(ipv6='', ip='');

opt = HTTPOptions(ConnectTimeout=8);

for ep = endpoints
  uri = URI(ep.url);
  request = RequestMessage();
  
  try
    resp = request.send(uri, opt);
  catch ME
    % fprintf(2, '%s failed: %s\n', ep.name, ME.message);
    continue
  end

  if resp.StatusCode == StatusCode.OK
    data = resp.Body.Data;

    switch ep.name
      case {'ipify6', 'ipify4'}
        ip = data.ip;
        if contains(ep.url, "api6")
          result.ipv6 = ip;
        else
          result.ip = ip;
        end
      case 'ident'
        result.ip = data.ip;
    end

    return
  end
end

error('Failed to retrieve any public IP address.')

end
