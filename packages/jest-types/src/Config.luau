-- upstream: https://github.com/facebook/jest/blob/v27.4.7/packages/jest-types/src/Config.ts
--[[*
 * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 ]]

local rootWorkspace = script.Parent.Parent
local LuauPolyfill = require(rootWorkspace.LuauPolyfill)
type Array<T> = LuauPolyfill.Array<T>
type Object = LuauPolyfill.Object

local RegExp = require(rootWorkspace.RegExp)
type RegExp = RegExp.RegExp

type Record<T, U> = { [T]: U }
type TemplateStringsArray = Array<string>

-- deviation START: Libraries/types not available
-- local chalkModule = require(rootWorkspace.chalk)
-- type ForegroundColor = chalkModule.ForegroundColor
type ForegroundColor = string

-- local istanbul_reportsModule = require(rootWorkspace["istanbul-reports"])
-- type ReportOptions = istanbul_reportsModule.ReportOptions
type ReportOptions = Object

-- local yargsModule = require(rootWorkspace.yargs)
-- type Arguments = yargsModule.Arguments
type Arguments<T> = T & Object
-- deviation END: Libraries/types not available

type CoverageProvider = "babel" | "v8"

type Timers = "real" | "fake" | "modern" | "legacy"

export type Path = string

export type Glob = string

export type HasteConfig = {
	--[[* Whether to hash files using SHA-1. ]]
	computeSha1: boolean?,
	--[[* The platform to use as the default, e.g. 'ios'. ]]
	defaultPlatform: (string | nil)?,
	--[[* Force use of Node's `fs` APIs rather than shelling out to `find` ]]
	forceNodeFilesystemAPI: boolean?,
	--[[*
  	 * Whether to follow symlinks when crawling for files.
  	 *   This options cannot be used in projects which use watchman.
  	 *   Projects with `watchman` set to true will error if this option is set to true.
  	 ]]
	enableSymlinks: boolean?,
	--[[* Path to a custom implementation of Haste. ]]
	hasteImplModulePath: string?,
	--[[* All platforms to target, e.g ['ios', 'android']. ]]
	platforms: Array<string>?,
	--[[* Whether to throw on error on module collision. ]]
	throwOnModuleCollision: boolean?,
	--[[* Custom HasteMap module ]]
	hasteMapModulePath: string?,
}

export type CoverageReporterName = string --[[ ROBLOX TODO: Unhandled node for type: TSTypeOperator ]] --[[ keyof ReportOptions ]]

-- FIXME: add default generic type <K = CoverageReporterName>
-- TODO: Unhandled node for type: TSConditionalType ]] --[[ K extends CoverageReporterName ? ReportOptions[K] extends never ? never : [K, Partial<ReportOptions[K]>] : never
export type CoverageReporterWithOptions<K> =
	Array<string | Object> --[[ [K, Partial<ReportOptions[K]>] ]]
	| nil

export type CoverageReporters = Array<CoverageReporterName | CoverageReporterWithOptions<CoverageReporterName>>

export type ReporterConfig = Array<string | Record<string, any>>

export type TransformerConfig = Array<string | Record<string, any>>

export type ConfigGlobals = {
	[string]: any,
}

-- This interface gets filled out when pretty-format is included
export type PrettyFormatOptions = {}

export type DefaultOptions = {
	automock: boolean,
	bail: number,
	-- deviation START: caching not supported
	-- cache: boolean,
	-- cacheDirectory: Path,
	-- deviation END
	-- deviation START: not supported
	-- changedFilesWithAncestor: boolean,
	-- deviation END
	ci: boolean,
	clearMocks: boolean,
	-- deviation START: not supported
	-- collectCoverage: boolean,
	-- coveragePathIgnorePatterns: Array<string>,
	-- coverageReporters: Array<CoverageReporterName>,
	-- coverageProvider: CoverageProvider,
	-- detectLeaks: boolean,
	-- detectOpenHandles: boolean,
	-- errorOnDeprecated: boolean,
	-- deviation END
	expand: boolean,
	-- deviation START: not supported
	-- extensionsToTreatAsEsm: Array<Path>,
	-- forceCoverageMatch: Array<Glob>,
	-- deviation END
	globals: ConfigGlobals,
	-- deviation START: not supported
	-- haste: HasteConfig,
	-- deviation END
	injectGlobals: boolean,
	listTests: boolean,
	maxConcurrency: number,
	maxWorkers: number | string,
	-- deviation START: not supported
	-- moduleDirectories: Array<string>,
	-- moduleFileExtensions: Array<string>,
	-- moduleNameMapper: Record<string, string | Array<string>>,
	-- modulePathIgnorePatterns: Array<string>,
	-- deviation END
	noStackTrace: boolean,
	-- deviation START: not supported
	-- notify: boolean,
	-- notifyMode: NotifyMode,
	-- deviation END
	passWithNoTests: boolean,
	-- deviation START: not supported
	-- prettierPath: string,
	-- deviation END
	resetMocks: boolean,
	resetModules: boolean,
	restoreMocks: boolean,
	roots: Array<Path>,
	runTestsByPath: boolean,
	runner: string,
	setupFiles: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>,
	setupFilesAfterEnv: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>,
	skipFilter: boolean,
	slowTestThreshold: number,
	snapshotSerializers: Array<Path>,
	testEnvironment: string,
	testEnvironmentOptions: Record<string, any>,
	testFailureExitCode: string | number,
	testLocationInResults: boolean,
	testMatch: Array<Glob>,
	testPathIgnorePatterns: Array<string>,
	testRegex: Array<string>,
	-- deviation START: not supported
	-- testRunner: string,
	-- testSequencer: string,
	-- testURL: string,
	-- deviation END
	timers: Timers,
	-- deviation START: not supported
	-- transformIgnorePatterns: Array<Glob>,
	-- useStderr: boolean,
	-- watch: boolean,
	-- watchPathIgnorePatterns: Array<string>,
	-- watchman: boolean,
	-- deviation END
}

export type DisplayName = {
	name: string,
	color: string, --[[ ROBLOX TODO: Unhandled node for type: TSTypeQuery ]] --[[ typeof ForegroundColor ]]
}

-- deviation: inline Required<Pick<InitialOptions, 'rootDir'>>
export type InitialOptionsWithRootDir = InitialOptions & { rootDir: Path }

-- deviation: inline Pick<InitialOptions & {cwd?: string}, keyof ProjectConfig>
export type InitialProjectOptions = {
	automock: boolean?,
	-- deviation START: not supported
	-- cache: boolean?,
	-- cacheDirectory: Path?,
	-- deviation END
	clearMocks: boolean?,
	-- deviation START: not supported
	-- coveragePathIgnorePatterns: Array<string>?,
	-- dependencyExtractor: string?,
	-- detectLeaks: boolean?,
	-- detectOpenHandles: boolean?,
	-- deviation END
	displayName: (string | DisplayName)?,
	-- deviation START: not supported
	-- extensionsToTreatAsEsm: Array<Path>?,
	-- extraGlobals: Array<string>?,
	-- deviation END
	filter: Path?,
	-- deviation START: not supported
	-- forceCoverageMatch: Array<Glob>?,
	-- globalSetup: (string | nil)?,
	-- globalTeardown: (string | nil)?,
	-- haste: HasteConfig?,
	-- deviation END
	injectGlobals: boolean?,
	-- deviation START: not supported
	-- moduleDirectories: Array<string>?,
	-- moduleFileExtensions: Array<string>?,
	-- deviation END
	moduleLoader: Path?,
	-- deviation START: not supported
	-- moduleNameMapper: { [string]: string | Array<string> }?,
	-- modulePathIgnorePatterns: Array<string>?,
	-- modulePaths: Array<string>?,
	-- deviation END
	name: string?,
	-- deviation START: not supported
	-- prettierPath: (string | nil)?,
	-- deviation END
	resetMocks: boolean?,
	resetModules: boolean?,
	-- deviation START: not supported
	-- resolver: (Path | nil)?,
	-- deviation END
	restoreMocks: boolean?,
	-- deviation START: using Instance instead of Path
	rootDir: Instance?,
	-- deviation END
	roots: Array<string>?,
	runner: string?,
	setupFiles: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>?,
	setupFilesAfterEnv: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>?,
	skipFilter: boolean?,
	skipNodeResolution: boolean?,
	slowTestThreshold: number?,
	-- deviation START: not supported
	-- snapshotResolver: Path?,
	-- deviation END
	snapshotSerializers: Array<Path>?,
	-- deviation START: not supported
	-- snapshotFormat: PrettyFormatOptions?,
	-- deviation END
	testEnvironment: string?,
	testEnvironmentOptions: Record<string, any>?,
	testLocationInResults: boolean?,
	testMatch: Array<Glob>?,
	testPathIgnorePatterns: Array<string>?,
	testRegex: (string | Array<string>)?,
	-- deviation START: not supported
	-- testRunner: string?,
	-- testURL: string?,
	-- deviation END
	timers: Timers?,
	-- deviation START: not supported
	-- transform: { [string]: Path | TransformerConfig }?,
	-- transformIgnorePatterns: Array<Glob>?,
	-- watchPathIgnorePatterns: Array<string>?,
	-- unmockedModulePathPatterns: Array<string>?,
	-- deviation END
} & {
	-- deviation START: not supported
	-- cwd: string?
	-- deviation END
}

-- deviation: replace Partial type making all fields optional
export type InitialOptions = {
	automock: boolean?,
	bail: (boolean | number)?,
	-- deviation START: not supported
	-- cache: boolean?,
	-- cacheDirectory: Path?,
	-- deviation END
	ci: boolean?,
	clearMocks: boolean?,
	-- deviation START: not supported
	-- changedFilesWithAncestor: boolean?,
	-- deviation END
	changedSince: string?,
	-- deviation START: not supported
	-- collectCoverage: boolean?,
	-- collectCoverageFrom: Array<Glob>?,
	-- collectCoverageOnlyFrom: { [string]: boolean }?,
	-- coverageDirectory: string?,
	-- coveragePathIgnorePatterns: Array<string>?,
	-- coverageProvider: CoverageProvider?,
	-- coverageReporters: CoverageReporters?,
	-- coverageThreshold: CoverageThreshold?,
	-- dependencyExtractor: string?,
	-- detectLeaks: boolean?,
	-- detectOpenHandles: boolean?,
	-- deviation END
	displayName: (string | DisplayName)?,
	expand: boolean?,
	-- deviation START: not supported
	-- extensionsToTreatAsEsm: Array<Path>?,
	-- extraGlobals: Array<string>?,
	-- deviation END
	filter: Path?,
	findRelatedTests: boolean?,
	-- deviation START: not supported
	-- forceCoverageMatch: Array<Glob>?,
	-- forceExit: boolean?,
	-- deviation END
	json: boolean?,
	globals: ConfigGlobals?,
	-- deviation START: not supported
	-- globalSetup: (string | nil)?,
	-- globalTeardown: (string | nil)?,
	-- haste: HasteConfig?,
	-- deviation END
	injectGlobals: boolean?,
	-- deviation START: not supported
	-- reporters: Array<string | ReporterConfig>?,
	-- logHeapUsage: boolean?,
	-- lastCommit: boolean?,
	-- deviation END
	listTests: boolean?,
	maxConcurrency: number?,
	maxWorkers: (number | string)?,
	-- deviation START: not supported
	-- moduleDirectories: Array<string>?,
	-- moduleFileExtensions: Array<string>?,
	-- deviation END
	moduleLoader: Path?,
	-- deviation START: not supported
	-- moduleNameMapper: { [string]: string | Array<string> }?,
	-- modulePathIgnorePatterns: Array<string>?,
	-- modulePaths: Array<string>?,
	-- deviation END
	name: string?,
	noStackTrace: boolean?,
	-- deviation START: not supported
	-- notify: boolean?,
	-- notifyMode: string?,
	-- onlyChanged: boolean?,
	-- onlyFailures: boolean?,
	-- deviation END
	outputFile: Path?,
	passWithNoTests: boolean?,
	--[[*
	* @deprecated Use `transformIgnorePatterns` options instead.
	]]
	preprocessorIgnorePatterns: Array<Glob>?,
	preset: (string | nil)?,
	-- deviation START: not supported
	-- prettierPath: (string | nil)?,
	-- deviation END
	projects: Array<Glob | InitialProjectOptions>?,
	-- deviation START: not supported
	-- replname: (string | nil)?,
	-- deviation END
	resetMocks: boolean?,
	resetModules: boolean?,
	-- deviation START: not supported
	-- resolver: (Path | nil)?,
	-- deviation END
	restoreMocks: boolean?,
	-- deviation START: using Instance instead of Path
	rootDir: Instance?,
	-- deviation END
	roots: Array<Path>?,
	runner: string?,
	runTestsByPath: boolean?,
	--[[*
  	 * @deprecated Use `transform` options instead.
  	 ]]
	scriptPreprocessor: string?,
	setupFiles: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>?,
	-- deviation START: not supported
	-- --[[*
	-- * @deprecated Use `setupFilesAfterEnv` options instead.
	-- ]]
	-- setupTestFrameworkScriptFile: Path?,
	-- deviation END
	setupFilesAfterEnv: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>?,
	silent: boolean?,
	skipFilter: boolean?,
	skipNodeResolution: boolean?,
	slowTestThreshold: number?,
	-- deviation START: not supported
	-- snapshotResolver: Path?,
	-- deviation END
	snapshotSerializers: Array<Path>?,
	-- deviation START: not supported
	-- snapshotFormat: PrettyFormatOptions?,
	-- errorOnDeprecated: boolean?,
	-- deviation END
	testEnvironment: string?,
	testEnvironmentOptions: Record<string, any>?,
	testFailureExitCode: (string | number)?,
	testLocationInResults: boolean?,
	testMatch: Array<Glob>?,
	testNamePattern: string?,
	--[[*
	 * @deprecated Use `roots` options instead.
	 ]]
	testPathDirs: Array<Path>?,
	testPathIgnorePatterns: Array<string>?,
	testRegex: (string | Array<string>)?,
	-- deviation START: not supported
	-- testResultsProcessor: string?,
	-- testRunner: string?,
	-- testSequencer: string?,
	-- testURL: string?,
	-- deviation END
	testTimeout: number?,
	timers: Timers?,
	-- deviation START: not supported
	-- transform: { [string]: Path | TransformerConfig }?,
	-- transformIgnorePatterns: Array<Glob>?,
	-- watchPathIgnorePatterns: Array<string>?,
	-- unmockedModulePathPatterns: Array<string>?,
	-- deviation END
	updateSnapshot: boolean?,
	-- deviation START: not supported
	-- useStderr: boolean?,
	-- deviation END
	verbose: boolean?,
	-- deviation START: not supported
	-- watch: boolean?,
	-- watchAll: boolean?,
	-- watchman: boolean?,
	-- watchPlugins: Array<string | Array<string | Record<string, any>>>?,
	-- deviation END
}

export type SnapshotUpdateState = "all" | "new" | "none"

type NotifyMode = "always" | "failure" | "success" | "change" | "success-change" | "failure-change"

export type CoverageThresholdValue = {
	branches: number?,
	functions: number?,
	lines: number?,
	statements: number?,
}

type CoverageThreshold = { [string]: CoverageThresholdValue, global: CoverageThresholdValue }

export type GlobalConfig = {
	bail: number,
	changedSince: string?,
	-- deviation START: not supported
	-- changedFilesWithAncestor: boolean,
	-- collectCoverage: boolean,
	-- collectCoverageFrom: Array<Glob>,
	-- collectCoverageOnlyFrom: { [string]: boolean }?,
	-- coverageDirectory: string,
	-- coveragePathIgnorePatterns: Array<string>?,
	-- coverageProvider: CoverageProvider,
	-- coverageReporters: CoverageReporters,
	-- coverageThreshold: CoverageThreshold?,
	-- detectLeaks: boolean,
	-- detectOpenHandles: boolean,
	-- deviation END
	expand: boolean,
	filter: Path?,
	-- deviation START: not supported
	-- findRelatedTests: boolean,
	-- forceExit: boolean,
	-- deviation END
	json: boolean,
	-- deviation START: not supported
	-- globalSetup: string?,
	-- globalTeardown: string?,
	-- lastCommit: boolean,
	-- logHeapUsage: boolean,
	-- deviation END
	listTests: boolean,
	maxConcurrency: number,
	maxWorkers: number,
	noStackTrace: boolean,
	nonFlagArgs: Array<string>,
	-- deviation START: not supported
	-- noSCM: boolean?,
	-- notify: boolean,
	-- notifyMode: NotifyMode,
	-- deviation END
	outputFile: Path?,
	-- deviation START: not supported
	-- onlyChanged: boolean,
	-- onlyFailures: boolean,
	-- deviation END
	passWithNoTests: boolean,
	-- deviation: using Instance instead of Glob
	projects: Array<Instance>,
	-- deviation START: not supported
	-- replname: string?,
	-- reporters: Array<string | ReporterConfig>?,
	-- deviation END
	runTestsByPath: boolean,
	-- deviation START: using Instance instead of Path
	rootDir: Instance,
	-- deviation END
	silent: boolean?,
	skipFilter: boolean,
	-- deviation START: not supported
	-- snapshotFormat: PrettyFormatOptions,
	-- errorOnDeprecated: boolean,
	-- deviation END
	testFailureExitCode: number,
	testNamePattern: string?,
	testPathPattern: string,
	-- deviation START: not supported
	-- testResultsProcessor: string?,
	-- testSequencer: string,
	-- deviation END
	testTimeout: number?,
	updateSnapshot: SnapshotUpdateState,
	-- deviation START: not supported
	-- useStderr: boolean,
	-- deviation END
	verbose: boolean?,
	-- deviation START: not supported
	-- watch: boolean,
	-- watchAll: boolean,
	-- watchman: boolean,
	-- watchPlugins: (Array<{
	-- 	path: string,
	-- 	config: Record<string, any>,
	-- }> | nil)?,
	-- deviation END
}
export type ProjectConfig = {
	automock: boolean,
	-- deviation START: caching not supported
	-- cache: boolean,
	-- cacheDirectory: Path,
	-- deviation END
	clearMocks: boolean,
	-- deviation START: not supported
	-- coveragePathIgnorePatterns: Array<string>,
	-- cwd: Path,
	-- dependencyExtractor: string?,
	-- detectLeaks: boolean,
	-- detectOpenHandles: boolean,
	-- deviation END
	displayName: DisplayName?,
	-- deviation START: not supported
	-- errorOnDeprecated: boolean,
	-- extensionsToTreatAsEsm: Array<Path>,
	-- extraGlobals: Array<string>, -- deviation: Array<keyof typeof globalThis>;
	-- deviation END
	filter: Path?,
	-- deviation START: not supported
	-- forceCoverageMatch: Array<Glob>,
	-- globalSetup: string?,
	-- globalTeardown: string?,
	-- globals: ConfigGlobals,
	-- haste: HasteConfig,
	-- deviation END
	injectGlobals: boolean,
	-- deviation START: not supported
	-- moduleDirectories: Array<string>,
	-- moduleFileExtensions: Array<string>,
	-- moduleLoader: Path?,
	-- moduleNameMapper: Array<Array<string>>,
	-- modulePathIgnorePatterns: Array<string>,
	-- modulePaths: Array<string>?,
	-- deviation END
	name: string,
	-- deviation START: not supported
	-- prettierPath: string,
	-- deviation END
	resetMocks: boolean,
	resetModules: boolean,
	-- deviation START: not supported
	-- resolver: Path?,
	-- deviation END
	restoreMocks: boolean,
	-- deviation START: using Instance instead of Path
	rootDir: Instance,
	-- deviation END
	roots: Array<Path>,
	runner: string,
	setupFiles: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>,
	setupFilesAfterEnv: Array<
		-- deviation START: using ModuleScript instead of Path
		ModuleScript
		-- deviation END
	>,
	skipFilter: boolean,
	-- deviation START: not supported
	-- skipNodeResolution: boolean?,
	-- deviation END
	slowTestThreshold: number,
	-- deviation START: not supported
	-- snapshotResolver: Path?,
	-- deviation END
	snapshotSerializers: Array<Path>,
	-- deviation START: not supported
	-- snapshotFormat: PrettyFormatOptions,
	-- deviation END
	testEnvironment: string,
	testEnvironmentOptions: Record<string, any>,
	testMatch: Array<Glob>,
	testLocationInResults: boolean,
	testPathIgnorePatterns: Array<string>,
	testRegex: Array<string | RegExp>,
	-- deviation START: not supported
	-- testRunner: string,
	-- testURL: string,
	-- deviation END
	timers: Timers,
	-- deviation START: not supported
	-- transform: Array<Array<string | Path | Record<string, any>>>,
	-- transformIgnorePatterns: Array<Glob>,
	-- watchPathIgnorePatterns: Array<string>,
	-- unmockedModulePathPatterns: Array<string>?,
	-- deviation END
}
-- deviation: replace Partial type making all fields optional
export type Argv = Arguments<{
	all: boolean?,
	automock: boolean?,
	bail: (boolean | number)?,
	-- deviation START: not supported
	-- cache: boolean?,
	-- cacheDirectory: string?,
	-- changedFilesWithAncestor: boolean?,
	-- deviation END
	changedSince: string?,
	ci: boolean?,
	clearCache: boolean?,
	clearMocks: boolean?,
	-- deviation START: not supported
	-- collectCoverage: boolean?,
	-- collectCoverageFrom: string?,
	-- collectCoverageOnlyFrom: Array<string>?,
	-- deviation END
	color: boolean?,
	colors: boolean?,
	config: string?,
	coverage: boolean?,
	-- deviation START: not supported
	-- coverageDirectory: string?,
	-- coveragePathIgnorePatterns: Array<string>?,
	-- coverageReporters: Array<string>?,
	-- coverageThreshold: string?,
	-- deviation END
	debug: boolean?,
	env: string?,
	expand: boolean?,
	-- deviation START: not supported
	-- findRelatedTests: boolean?,
	-- forceExit: boolean?,
	-- deviation END
	globals: string?,
	-- deviation START: not supported
	-- globalSetup: (string | nil)?,
	-- globalTeardown: (string | nil)?,
	-- haste: string?,
	-- deviation END
	init: boolean?,
	injectGlobals: boolean?,
	json: boolean?,
	-- deviation START: not supported
	-- lastCommit: boolean?,
	-- logHeapUsage: boolean?,
	-- deviation END
	maxWorkers: (number | string)?,
	-- deviation START: not supported
	-- moduleDirectories: Array<string>?,
	-- moduleFileExtensions: Array<string>?,
	-- moduleNameMapper: string?,
	-- modulePathIgnorePatterns: Array<string>?,
	-- modulePaths: Array<string>?,
	-- deviation END
	noStackTrace: boolean?,
	-- deviation START: not supported
	-- notify: boolean?,
	-- notifyMode: string?,
	-- onlyChanged: boolean?,
	-- onlyFailures: boolean?,
	-- deviation END
	outputFile: string?,
	preset: (string | nil)?,
	projects: Array<string>?,
	-- deviation START: not supported
	-- prettierPath: (string | nil)?,
	-- deviation END
	resetMocks: boolean?,
	resetModules: boolean?,
	-- deviation START: not supported
	-- resolver: (string | nil)?,
	-- deviation END
	restoreMocks: boolean?,
	-- deviation START: using Instance instead of string
	rootDir: Instance?,
	-- deviation END
	roots: Array<string>?,
	runInBand: boolean?,
	selectProjects: Array<string>?,
	setupFiles: Array<
		-- deviation START: using ModuleScript instead of string
		ModuleScript
		-- deviation END
	>?,
	setupFilesAfterEnv: Array<
		-- deviation START: using ModuleScript instead of string
		ModuleScript
		-- deviation END
	>?,
	showConfig: boolean?,
	silent: boolean?,
	snapshotSerializers: Array<string>?,
	testEnvironment: string?,
	testEnvironmentOptions: string?,
	testFailureExitCode: (string | nil)?,
	testMatch: Array<string>?,
	testNamePattern: string?,
	testPathIgnorePatterns: Array<string>?,
	testPathPattern: Array<string>?,
	testRegex: string | Array<string>?,
	-- deviation START: not supported
	-- testResultsProcessor: string?,
	-- testRunner: string?,
	-- testSequencer: string?,
	-- testURL: string?,
	-- deviation END
	testTimeout: (number | nil)?,
	timers: string?,
	-- deviation START: not supported
	-- transform: string?,
	-- transformIgnorePatterns: Array<string>?,
	-- unmockedModulePathPatterns: (Array<string> | nil)?,
	-- deviation END
	updateSnapshot: boolean?,
	-- deviation START: not supported
	-- useStderr: boolean?,
	-- deviation END
	verbose: boolean?,
	version: boolean?,
	-- deviation START: not supported
	-- watch: boolean?,
	-- watchAll: boolean?,
	-- watchman: boolean?,
	-- watchPathIgnorePatterns: Array<string>?,
	-- deviation END
}>

return {}
