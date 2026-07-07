%% RELEASETESTTAGS generate test tags based on MATLAB release version
% this avoids cluttering test results with Incomplete due to assumeFalse(isMATLABReleaseOlderThan)

function sel = releaseTestTags(sel)
import matlab.unittest.selectors.HasTag

r = matlabRelease().Release;

releasesKnown = ["R2020b", ...
"R2021a", "R2021b", "R2022a", "R2022b", ...
"R2023a", "R2023b", "R2024a", "R2024b", ...
"R2025a", "R2025b", "R2026a", "R2026b"];

% takes releases not newer than this release
idx = find(releasesKnown >= r, 1, 'first');
for i = idx:length(releasesKnown)
  sel = sel & ~HasTag(releasesKnown(i));
end

end
