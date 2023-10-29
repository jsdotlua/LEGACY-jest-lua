-- upstream: https://github.com/facebook/jest/blob/v28.0.0/packages/jest-config/src/getMaxWorkers.ts
--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]

local Packages = script.Parent.Parent
local LuauPolyfill = require(Packages.LuauPolyfill)
-- deviation START: no needed
-- local Boolean = LuauPolyfill.Boolean
-- deviation END
type Object = LuauPolyfill.Object

local exports = {}

-- deviation START: no needed
-- local cpus = require(Packages.os).cpus
-- deviation END
local typesModule = require(Packages.JestTypes)
type Config_Argv = typesModule.Config_Argv

-- deviation START: additional types
type Partial<U> = Object
type Pick<U, V> = Object
-- deviation END

local function getMaxWorkers(
	argv: Partial<Pick<Config_Argv, "maxWorkers" | "runInBand" | "watch" | "watchAll">>,
	defaultOptions: Partial<Pick<Config_Argv, "maxWorkers">>?
): number
	-- deviation START: no concurrent run allowed
	return 1
	-- if Boolean.toJSBoolean(argv.runInBand) then
	-- 	return 1
	-- elseif Boolean.toJSBoolean(argv.maxWorkers) then
	-- 	return parseWorkers(argv.maxWorkers)
	-- elseif
	-- 	Boolean.toJSBoolean(
	-- 		if Boolean.toJSBoolean(defaultOptions)
	-- 			then defaultOptions.maxWorkers
	-- 			else defaultOptions
	-- 	)
	-- then
	-- 	return parseWorkers(defaultOptions.maxWorkers)
	-- else
	-- 	-- In watch mode, Jest should be unobtrusive and not use all available CPUs.
	-- 	local cpusInfo = cpus()
	-- 	local ref = if typeof(cpusInfo) == "table" then cpusInfo.length else nil
	-- 	local numCpus = if ref ~= nil then ref else 1
	-- 	local isWatchModeEnabled = Boolean.toJSBoolean(argv.watch) and argv.watch or argv.watchAll
	-- 	return Math:max(
	-- 		if Boolean.toJSBoolean(isWatchModeEnabled) then Math:floor(numCpus / 2) else numCpus - 1,
	-- 		1
	-- 	)
	-- end
	-- deviation END
end
exports.default = getMaxWorkers

-- deviation START: no needed
-- local function parseWorkers(maxWorkers: string | number): number
-- 	local parsed = tonumber(tostring(maxWorkers), 10)
-- 	if
-- 		Boolean.toJSBoolean((function()
-- 			local ref = typeof(maxWorkers) == "string" and maxWorkers:trim():endsWith("%")
-- 			local ref = if Boolean.toJSBoolean(ref)
-- 				then
-- 					parsed
-- 					> 0 --[[ CHECK: operator '>' works only if either both arguments are strings or both are a number ]]
-- 				else ref
-- 			return if Boolean.toJSBoolean(ref)
-- 				then
-- 					parsed
-- 					<= 100 --[[ CHECK: operator '<=' works only if either both arguments are strings or both are a number ]]
-- 				else ref
-- 		end)())
-- 	then
-- 		local numCpus = cpus().length
-- 		local workers = Math:floor(parsed / 100 * numCpus)
-- 		return Math:max(workers, 1)
-- 	end
-- 	return if parsed > 0 then parsed else 1
-- end
-- deviation END

return exports
