%% RELEASETESTTAGS generate test tags based on MATLAB release version
% this avoids cluttering test results with Incomplete due to assumeFalse(isMATLABReleaseOlderThan)

function tags = releaseTestTags()

try
  r = matlabRelease().Release;
catch
  r = "R" + version('-release');
end

releasesKnown = [
"R2019b", "R2020a", "R2020b", "R2021a", "R2021b", ...
"R2022a", "R2022b", "R2023a", "R2023b", "R2024a", ...
"R2024b", "R2025a", "R2025b"];

% takes releases not newer than this release
idx = find(releasesKnown >= r, 1, 'first');
if ~isempty(idx)
  tags = releasesKnown(1:idx);
end

end
