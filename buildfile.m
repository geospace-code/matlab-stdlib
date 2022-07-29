function plan = buildfile
plan = buildplan(localfunctions);
end

function lintTask(~)
assertSuccess(runtests('stdlib.test.TestLint'))
end

function testTask(~)
assertSuccess(runtests('stdlib.test'))
end
