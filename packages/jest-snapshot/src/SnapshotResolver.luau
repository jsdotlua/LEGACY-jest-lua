-- upstream: https://github.com/facebook/jest/blob/v28.0.0/packages/jest-snapshot/src/SnapshotResolver.ts
--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]

local Packages = script.Parent.Parent
local LuauPolyfill = require(Packages.LuauPolyfill)
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local String = LuauPolyfill.String
type Array<T> = LuauPolyfill.Array<T>
type Promise<T> = LuauPolyfill.Promise<T>
local Promise = require(Packages.Promise)

local exports = {}

-- deviation START: not needed
-- local path = require(Packages.path)
-- local chalk = require(Packages.ChalkLua)
-- local createTranspilingRequire = require(Packages["@jest"].transform).createTranspilingRequire
-- deviation END
local typesModule = require(Packages.JestTypes)
type Config_Path = typesModule.Config_Path
type Config_ProjectConfig = typesModule.Config_ProjectConfig
-- deviation START: not needed
-- local interopRequireDefault = require(Packages.JestUtil).interopRequireDefault
-- deviation END

-- deviation START: additinal dependencies
local utils = require(script.Parent.utils)
local getParent = utils.robloxGetParent

local function getCoreScriptSyncService()
	local success, result = pcall(function()
		return game:GetService("CoreScriptSyncService")
	end)

	return success and result or nil
end
local CoreScriptSyncService = nil
-- deviation END

-- deviation START: predefine functions
local createSnapshotResolver
local createDefaultSnapshotResolver
--- deviation END
export type SnapshotResolver = {
	-- deviation START: not supported
	-- testPathForConsistencyCheck: string,
	-- deviation END
	-- deviation START: custom return value. We need to be able to resolve both snapshot instance and path
	resolveSnapshotPath: (
		self: SnapshotResolver,
		testPath: ModuleScript,
		extension: string?
	) -> {
		getInstance: () -> ModuleScript?,
		getPath: () -> string,
	},
	-- deviation END
	-- deviation START: not supported
	-- resolveTestPath: (self: any, snapshotPath: Config_Path, extension: string?) -> Config_Path,
	-- deviation END
}
local EXTENSION = "snap"
exports.EXTENSION = EXTENSION
local DOT_EXTENSION = "." .. EXTENSION
exports.DOT_EXTENSION = DOT_EXTENSION

local function isSnapshotPath(path: string): boolean
	return String.endsWith(path, DOT_EXTENSION)
end
exports.isSnapshotPath = isSnapshotPath

local cache = Map.new()
type LocalRequire = (module: string) -> unknown

local function buildSnapshotResolver(
	config: Config_ProjectConfig,
	-- deviation: not supported
	_localRequire: (Promise<LocalRequire> | LocalRequire)?
	-- deviation END
): Promise<SnapshotResolver>
	-- deviation: not supported
	-- if localRequire == nil then
	-- 	localRequire = createTranspilingRequire(config)
	-- end
	-- deviation END
	return Promise.resolve():andThen(function()
		local key = config.rootDir
		local ref = cache:get(key)
		local resolver = if ref ~= nil
			then ref
			else createSnapshotResolver(
				-- deviation: not supported
				-- localRequire:expect(), config.snapshotResolver
				-- deviation END
			):expect()
		cache:set(key, resolver)
		return resolver
	end)
end
exports.buildSnapshotResolver = buildSnapshotResolver

function createSnapshotResolver(--[[ deviation: not supported ]]--[[
	localRequire: LocalRequire,
	snapshotResolverPath: (Config_Path | nil)?
]]--[[ deviation END ]]): Promise<SnapshotResolver>
	return Promise.resolve():andThen(function()
		-- deviation START: only support default snapshot resolver
		-- return if typeof(snapshotResolverPath) == "string"
		-- 	then createCustomSnapshotResolver(snapshotResolverPath, localRequire):expect()
		-- 	else createDefaultSnapshotResolver()
		return createDefaultSnapshotResolver()
		-- deviation END
	end)
end

function createDefaultSnapshotResolver(): SnapshotResolver
	return {
		resolveSnapshotPath = function(
			_self: SnapshotResolver,
			-- deviation START: using ModuleScript instead of Config_Path
			testPath: ModuleScript
			-- deviation END
		)
			-- deviation START: custom implementation
			return {
				getInstance = function()
					local testFileName = testPath.Name
					local snapshotPath: ModuleScript? = nil
					pcall(function()
						snapshotPath = (testPath.Parent :: any).__snapshots__[testFileName .. DOT_EXTENSION]
					end)
					return snapshotPath
				end,
				getPath = function()
					if CoreScriptSyncService == nil then
						CoreScriptSyncService = getCoreScriptSyncService() or false
					end
					if not CoreScriptSyncService then
						error(
							Error(
								"Attempting to save snapshots in an environment where CoreScriptSyncService is inaccessible.\n"
									.. "You may need to pass in --load.asRobloxScript."
							)
						)
					end

					local ok, result = pcall(function()
						return CoreScriptSyncService:GetScriptFilePath(testPath)
					end)
					if not ok then
						local err = result
						if string.find(err, "lacking permission 5") then
							error(
								Error.new(
									string.format(
										"Could not get a snapshot path for test file '%s'. You may need to pass in --load.asRobloxScript",
										testPath.Name
									)
								)
							)
						else
							error(
								Error.new(
									string.format(
										"Could not get a snapshot path for test file '%s' because of the following error: %s",
										testPath.Name,
										err
									)
								)
							)
						end
					end
					local snapshotPath = result
					local parentPath = getParent(snapshotPath, 1)
					local snapshotFileName = testPath.Name .. DOT_EXTENSION .. ".lua"

					return ("%s/__snapshots__/%s"):format(parentPath, snapshotFileName)
				end,
			}
			-- deviation END
		end,
		-- deviation START: not supported
		-- resolveTestPath = function(snapshotPath: Config_Path)
		-- 	return path:resolve(path:dirname(snapshotPath), "..", path:basename(snapshotPath, DOT_EXTENSION))
		-- end,
		-- testPathForConsistencyCheck = path.posix.join("consistency_check", "__tests__", "example.test.js"),
		-- deviation END
	}
end

--[[
	deviation: skipped lines 56-132
	original code: https://github.com/facebook/jest/blob/v28.0.0/packages/jest-snapshot/src/SnapshotResolver.ts#L56-L132
]]

return exports
