%% VERSION_ATLEAST compare two string verions: major.minor.rev.patch
% compare two string verions: major.minor.rev.patch
% uses strings to compare so mixed number/string is OK
%
%% Inputs
% * in: version to examine (string)
% * ref: version to compare against (at least this version is true)
%% Outputs
% * r: logical

function r = version_atleast(in, ref)
arguments
  in (1,1) string
  ref (1,1) string
end


if stdlib.isoctave()
  r = compare_versions(in, ref, '>=');
  return
end

inp = split(in, ' ');
in_str = split(inp(1), ".");

refp = split(ref, ' ');
ref_str = split(refp(1), ".");

% Compare numeric parts first
for i = 1:min(length(in_str), length(ref_str))
  in_num = double(in_str(i));
  ref_num = double(ref_str(i));

  if isnan(in_num) || isnan(ref_num)
    % assume values are leading integer with trailing string
    % extract integer part and compare
    in_num = double(regexp(in_str(i), "\d+", "match", "once"));
    ref_num = double(regexp(ref_str(i), "\d+", "match", "once"));

    if isnan(in_num) || isnan(ref_num) || in_num == ref_num
      % compare string parts
      in_str_part = regexp(in_str(i), "\D+", "match", "once");
      ref_str_part = regexp(ref_str(i), "\D+", "match", "once");
      if in_str_part > ref_str_part
        r = true;
        return
      elseif in_str_part < ref_str_part
        r = false;
        return
      end

      continue
    end
  end

  % Compare numerically
  if in_num > ref_num
    r = true;
    return
  elseif in_num < ref_num
    r = false;
    return
  end
end

% If all compared parts are equal, compare lengths
r = length(in_str) >= length(ref_str);

end

%!assert(version_atleast("1.2.3", "1.2"))
%!assert(version_atleast("20.11a", "20.3b"))
