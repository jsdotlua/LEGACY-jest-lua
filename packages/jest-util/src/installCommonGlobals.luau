-- upstream: https://github.com/facebook/jest/tree/v28.0.0/packages/jest-util/src/installCommonGlobals.ts

--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]

-- deviation: returning a function to be able to re-execute the module in tests
return function()
	local CurrentModule = script.Parent
	local Packages = CurrentModule.Parent
	local LuauPolyfill = require(Packages.LuauPolyfill)
	local Array = LuauPolyfill.Array
	local Object = LuauPolyfill.Object
	local String = LuauPolyfill.String
	local Symbol = LuauPolyfill.Symbol

	local Promise = require(Packages.Promise)

	local exports = {}

	-- deviation: fs not necessary
	-- local fs = require(Packages["graceful-fs"])
	local typesModule = require(Packages.JestTypes)
	type Config_ConfigGlobals = typesModule.Config_ConfigGlobals
	local createProcessObject = require(script.Parent.createProcessObject).default
	local deepCyclicCopy = require(script.Parent.deepCyclicCopy).default

	local DTRACE = Array.filter(Object.keys(_G), function(key)
		return typeof(key) == "string" and String.startsWith(key, "DTRACE")
	end)

	exports.default = function(
		globalObject: typeof(_G),
		globals: Config_ConfigGlobals
	): typeof(_G) & Config_ConfigGlobals
		-- deviation: added self to be able to bind DTRACE functions
		local self = globalObject
		globalObject.process = createProcessObject()
		-- Keep a reference to some globals that Jest needs
		Object.assign(globalObject, {
			-- deviation START: not making props readonly
			-- FIXME: have to cast element to `any` to avoid type narrowing issue
			[Symbol.for_("jest-native-promise")] = Promise :: any,
			[Symbol.for_("jest-native-now")] = DateTime.now,
			-- deviation END
			-- deviation START: skipped fs related globals
			-- [Symbol.for_("jest-native-read-file")] = {
			-- 	enumerable = false,
			-- 	value = fs.readFileSync:bind(fs),
			-- 	writable = false,
			-- },
			-- [Symbol.for_("jest-native-write-file")] = {
			-- 	enumerable = false,
			-- 	value = fs.writeFileSync:bind(fs),
			-- 	writable = false,
			-- },
			-- [Symbol.for_("jest-native-exists-file")] = {
			-- 	enumerable = false,
			-- 	value = fs.existsSync:bind(fs),
			-- 	writable = false,
			-- },
			-- deviation END
			-- deviation START: not making props readonly
			["jest-symbol-do-not-touch"] = Symbol,
			-- deviation END
		})

		-- Forward some APIs.
		Array.forEach(DTRACE, function(dtrace)
			-- @ts-expect-error: no index
			globalObject[dtrace] = function(_self, ...: any)
				local args = { ... }
				-- @ts-expect-error: no index
				return _G[dtrace](self, table.unpack(args))
			end
		end)
		return Object.assign(globalObject, deepCyclicCopy(globals))
	end
	return exports
end
