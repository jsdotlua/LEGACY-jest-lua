--[[
	* Copyright (c) Roblox Corporation. All rights reserved.
	* Licensed under the MIT License (the "License");
	* you may not use this file except in compliance with the License.
	* You may obtain a copy of the License at
	*
	*     https://opensource.org/licenses/MIT
	*
	* Unless required by applicable law or agreed to in writing, software
	* distributed under the License is distributed on an "AS IS" BASIS,
	* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	* See the License for the specific language governing permissions and
	* limitations under the License.
]]
-- NOTE: no upstream

-- TODO: implement in LuauPolyfill

local CurrentModule = script.Parent
local Packages = CurrentModule.Parent
local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array
type Array<T> = LuauPolyfill.Array<T>

local RegExp = require(Packages.RegExp)
type RegExp = RegExp.RegExp

local function stringReplace(str: string, regExp: RegExp, replFn: (...any) -> string)
	local v = str
	local match = regExp:exec(v)
	local offset = 0
	local replaceArr = {}
	while match ~= nil and match.index ~= nil do
		-- FIXME Luau: analyze complains about match type being `Array<string> & {| index: number?, input: string?, n: number |}` instead of table
		local m = (match :: Array<string>)[1]
		local args: Array<string | number> = Array.slice(match, 1, match.n + 1)
		-- FIXME Luau: analyze doesn't recognize match.index as a number
		local index = (match.index :: any) + offset

		table.insert(args, index)

		local replace = replFn(table.unpack(args))

		table.insert(replaceArr, {
			from = index,
			length = #m,
			value = replace,
		})

		-- FIXME Luau: analyze doesn't recognize match.index as a number
		offset += #m + (match.index :: any) - 1
		v = str:sub(offset + 1)
		match = regExp:exec(v)
	end
	local result = str:sub(1)
	for _, rep in ipairs(Array.reverse(replaceArr)) do
		local from, length, value = rep.from, rep.length, rep.value
		local prefix = result:sub(1, from - 1)
		local suffix = result:sub(from + length)

		result = prefix .. value .. suffix
	end

	return result
end

return {
	stringReplace = stringReplace,
}
