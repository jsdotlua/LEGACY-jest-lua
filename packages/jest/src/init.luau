-- upstream: https://github.com/facebook/jest/blob/v28.0.0/packages/jest/src/jest.ts
--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]

local Packages = script.Parent

local exports = {}
local coreModule = require(Packages.JestCore)
exports.SearchSource = coreModule.SearchSource
exports.TestWatcher = coreModule.TestWatcher
exports.createTestScheduler = coreModule.createTestScheduler
-- deviation START: not ported
-- exports.getVersion = coreModule.getVersion
-- deviation END
exports.runCLI = coreModule.runCLI
-- deviation START: JestCli is not ported
-- exports.run = require(Packages.JestCli).run
-- deviation END
return exports
