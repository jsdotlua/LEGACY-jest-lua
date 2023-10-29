-- upstream: https://github.com/facebook/jest/blob/v28.0.0/packages/jest-config/src/Defaults.ts
--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]

local Packages = script.Parent.Parent
local exports = {}

-- deviation START: hardcode values
-- local sep = require(Packages.path).sep
-- local isCI = require(Packages["ci-info"]).isCI
local isCI = false
-- deviation END
local typesModule = require(Packages.JestTypes)
type Config_DefaultOptions = typesModule.Config_DefaultOptions
-- deviation START: not needed
-- local replacePathSepForRegex = require(Packages["jest-regex-util"]).replacePathSepForRegex
-- local NODE_MODULES = require(script.Parent.constants).NODE_MODULES
-- local getCacheDirectory = require(script.Parent.getCacheDirectory).default
-- local NODE_MODULES_REGEXP = replacePathSepForRegex(NODE_MODULES)
-- deviation END
local defaultOptions: Config_DefaultOptions = {
	automock = false,
	bail = 0,
	-- deviation START: caching not supported
	-- cache = true,
	-- cacheDirectory = getCacheDirectory(),
	-- deviation END
	changedFilesWithAncestor = false,
	ci = isCI,
	clearMocks = false,
	-- deviation START: not supported
	-- collectCoverage = false,
	-- deviation END
	coveragePathIgnorePatterns = {
		-- deviation START: no node_modules
		-- NODE_MODULES_REGEXP
		-- deviation END
	},
	-- deviation START: not supported
	-- coverageProvider = "babel",
	-- coverageReporters = { "json", "text", "lcov", "clover" },
	-- detectLeaks = false,
	-- detectOpenHandles = false,
	-- errorOnDeprecated = false,
	-- deviation END
	expand = false,
	-- deviation START: not supported
	-- extensionsToTreatAsEsm = {},
	-- forceCoverageMatch = {},
	-- deviation END
	globals = {},
	-- deviation START: not supported
	-- haste = {
	-- 	computeSha1 = false,
	-- 	enableSymlinks = false,
	-- 	forceNodeFilesystemAPI = false,
	-- 	throwOnModuleCollision = false,
	-- },
	-- deviation END
	injectGlobals = true,
	listTests = false,
	maxConcurrency = 5,
	maxWorkers = "50%",
	-- deviation START: not supported
	-- moduleDirectories = { "node_modules" },
	-- moduleFileExtensions = { "js", "jsx", "ts", "tsx", "json", "node" },
	-- moduleNameMapper = {},
	-- modulePathIgnorePatterns = {},
	-- deviation END
	noStackTrace = false,
	notify = false,
	-- deviation START: not supported
	-- notifyMode = "failure-change",
	-- deviation END
	passWithNoTests = false,
	-- deviation START: not supported
	-- prettierPath = "prettier",
	-- deviation END
	resetMocks = false,
	resetModules = false,
	restoreMocks = false,
	roots = { "<rootDir>" },
	runTestsByPath = false,
	runner = "jest-runner",
	setupFiles = {},
	setupFilesAfterEnv = {},
	skipFilter = false,
	slowTestThreshold = 5,
	snapshotSerializers = {},
	testEnvironment = Packages.JestEnvironmentLuau,
	testEnvironmentOptions = {},
	testFailureExitCode = 1,
	testLocationInResults = false,
	-- deviation START: using lua files as defaults for tests
	testMatch = { "**/__tests__/**/*", "**/?(*.)+(spec|test)" },
	-- deviation END
	testPathIgnorePatterns = {
		-- deviation START: no node_modules
		-- NODE_MODULES_REGEXP
		-- deviation END
	},
	testRegex = {},
	-- deviation START: not supported
	-- testRunner = "jest-circus/runner",
	-- testSequencer = "@jest/test-sequencer",
	-- testURL = "http://localhost",
	-- deviation END
	timers = "real",
	-- deviation START: not supported
	-- transformIgnorePatterns = {
	-- 	NODE_MODULES_REGEXP,
	-- 	("\\.pnp\\.[^\\%s]+$"):format(tostring(sep)),
	-- },
	-- deviation END
	useStderr = false,
	watch = false,
	watchPathIgnorePatterns = {},
	watchman = true,
}
exports.default = defaultOptions
return exports
