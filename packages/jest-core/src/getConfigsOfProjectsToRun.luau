-- upstream: https://github.com/facebook/jest/blob/v28.0.0/packages/jest-core/src/getConfigsOfProjectsToRun.ts
--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]
local Packages = script.Parent.Parent
local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
type Array<T> = LuauPolyfill.Array<T>

local exports = {}

local typesModule = require(Packages.JestTypes)
type Config_ProjectConfig = typesModule.Config_ProjectConfig
local getProjectDisplayName = require(script.Parent.getProjectDisplayName).default

-- deviation START: add hoisted function declarations
local createProjectFilter
-- deviation END

local function getConfigsOfProjectsToRun(
	projectConfigs: Array<Config_ProjectConfig>,
	opts: {
		ignoreProjects: Array<string> | nil,
		selectProjects: Array<string> | nil,
	}
): Array<Config_ProjectConfig>
	local projectFilter = createProjectFilter(opts)
	return Array.filter(projectConfigs, function(config)
		local name = getProjectDisplayName(config)
		return projectFilter(name)
	end)
end
exports.default = getConfigsOfProjectsToRun

-- deviation START: predeclared function
-- local function createProjectFilter(opts: {
function createProjectFilter(
	opts: {
		-- deviation END
		ignoreProjects: Array<string> | nil,
		selectProjects: Array<string> | nil,
	}
)
	-- deviation START: ensure arrays are not nil for 'includes'
	-- local selectProjects, ignoreProjects = opts.selectProjects, opts.ignoreProjects
	local selectProjects, ignoreProjects =
		if Array.isArray(opts.selectProjects) then opts.selectProjects :: Array<string> else {} :: Array<string>,
		if Array.isArray(opts.ignoreProjects) then opts.ignoreProjects :: Array<string> else {} :: Array<string>
	-- deviation END

	local function always()
		return true
	end

	-- deviation START: use length check instead of JSBoolean check for table
	-- local selected = if Boolean.toJSBoolean(selectProjects)
	local selected: (string?) -> boolean | string? = if #selectProjects > 0
		-- deviation END
		then function(name: string | nil)
			return if Boolean.toJSBoolean(name) then Array.includes(selectProjects, name) else name
		end
		else always

	-- deviation START: use length check instead of JSBoolean check for table
	-- local notIgnore = if Boolean.toJSBoolean(ignoreProjects)
	local notIgnore: (string?) -> boolean = if #ignoreProjects > 0
		-- deviation END
		then function(name: string | nil)
			return not Boolean.toJSBoolean(
				if Boolean.toJSBoolean(name) then Array.includes(ignoreProjects, name) else name
			)
		end
		else always

	-- deviation START: always return boolean
	-- local function test(name: string | nil)
	-- 	local ref = selected(name)
	-- 	return if Boolean.toJSBoolean(ref) then notIgnore(name) else ref
	-- end
	local function test(name: string | nil): boolean
		return Boolean.toJSBoolean(selected(name)) and Boolean.toJSBoolean(notIgnore(name))
	end
	-- deviation END

	return test
end

return exports
