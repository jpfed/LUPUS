verboseOutput = false
if arg[1] ~= nil then verboseOutput = true end

require("tests/test_base")
require("tests/test_collections")
require("tests/test_higher")
require("tests/test_numeric")
require("tests/test_random")
require("tests/test_vector")