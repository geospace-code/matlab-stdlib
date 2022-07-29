function plan = buildfile
plan = buildplan(localfunctions);
end

function lintTask(~)
assertSuccess(runtests('stdlib.TestLint'))
end

function testTask(~)
assertSuccess(runtests('stdlib'))
end
