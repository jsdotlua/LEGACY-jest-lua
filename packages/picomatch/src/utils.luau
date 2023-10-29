--[[
The MIT License (MIT)

Copyright (c) 2017-present, Jon Schlinkert.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT ! LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]
-- upstream: https://github.com/micromatch/picomatch/tree/2.3.1/lib/utils.js

local CurrentModule = script.Parent
local Packages = CurrentModule.Parent
local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local String = LuauPolyfill.String
type Object = LuauPolyfill.Object

local exports = {}

-- deviation: skipping path
-- local path = require("path")
-- FIXME: make proper platform check
-- local win32 = process.platform == "win32"
local win32 = false
local Constants = require(CurrentModule.constants)
-- TODO START: implement missing RegExp when 'g' flag available (or reimplement without RegExp)
local REGEX_SPECIAL_CHARS = Constants.REGEX_SPECIAL_CHARS
-- local REGEX_BACKSLASH, REGEX_REMOVE_BACKSLASH, REGEX_SPECIAL_CHARS, REGEX_SPECIAL_CHARS_GLOBAL =
-- 	Constants.REGEX_BACKSLASH,
-- 	Constants.REGEX_REMOVE_BACKSLASH,
-- 	Constants.REGEX_SPECIAL_CHARS,
local REGEX_SPECIAL_CHARS_GLOBAL = Constants.REGEX_SPECIAL_CHARS_GLOBAL
-- TODO END

function exports.isObject(val)
	return val ~= nil and typeof(val) == "table" and not Array.isArray(val)
end
function exports.hasRegexChars(str)
	return string.match(str, REGEX_SPECIAL_CHARS) ~= nil
end
function exports.isRegexChar(str: string)
	return #str == 1 and exports.hasRegexChars(str)
end
-- deviation START: additional dependencies
local String_replace = require(CurrentModule.stringUtils).stringReplace
-- deviation END

function exports.escapeRegex(str): string
	-- deviation: using custom String_replace function
	return String_replace(str, REGEX_SPECIAL_CHARS_GLOBAL, function(m)
		return "\\" .. m
	end)
	-- return str:replace(REGEX_SPECIAL_CHARS_GLOBAL, "\\$1")
	-- deviation END
end
function exports.toPosixSlashes(str): string
	error("toPosixSlashes not implemented")
	-- return str:replace(REGEX_BACKSLASH, "/")
end

function exports.removeBackslashes(str): string
	error("removeBackslashes not implemented")
	-- return str:replace(REGEX_REMOVE_BACKSLASH, function(match)
	-- 	return match == "\\" and "" or match
	-- end)
end
-- TODO END

function exports.supportsLookbehinds()
	-- CHECK: do we suppoert lookbehind in Lua?
	-- deviation: no equivalent check in Lua. Returning always false
	return false
end

function exports.isWindows(options: Object?): boolean
	if typeof(options) == "table" and typeof(options.windows) == "boolean" then
		return options.windows
	end
	--[[
		ROBLOX deviation: not using path.sep as it's not available
		original code:
		return win32 === true || path.sep === '\\';
	]]
	return win32 == true
end

function exports.escapeLast(input: string, char: string, lastIdx: number?)
	local idx = String.lastIndexOf(input, char, lastIdx)
	if idx == -1 then
		return input
	end
	if input:sub(idx - 1, idx - 1) == "\\" then
		return exports.escapeLast(input, char, idx - 1)
	end
	return ("%s%s"):format(String.slice(input, 1, idx), String.slice(input, idx))
end

function exports.removePrefix(input: string, state_: Object?)
	local state: Object = state_ or {}

	local output = input
	if String.startsWith(output, "./") then
		output = String.slice(output, 3)
		state.prefix = "./"
	end
	return output
end
function exports.wrapOutput(input, state_: Object?, options_: Object?)
	local state: Object = state_ or {}
	local options: Object = options_ or {}

	local prepend = if Boolean.toJSBoolean(options.contains) then "" else "^"
	local append = if Boolean.toJSBoolean(options.contains) then "" else "$"

	local output = ("%s(?:%s)%s"):format(prepend, input, append)
	if state.negated == true then
		output = ("(?:^(?!%s).*$)"):format(output)
	end
	return output
end

return exports
