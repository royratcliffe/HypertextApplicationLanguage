# Change Log

## [1.0.0](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/1.0.0) (2017-02-18)

- Added What Can You Do With It? section to README
- Link for self-relation matches first link
- Added parsing test
- Name rendering tests as `testRender`
- Update copyright years
- Tests for representation parsing and rendering
- Make Swift package manager aware of fixtures
- Use `type(of: self)` to access self class
- Link imports Foundation for `NSRegularExpression`
- Added tools for loading JSON from test bundle
- Added JSON parsing and rendering methods
- Added `Link.with()` methods
- Fixed comment for `Link.templated` getter
- `Link.templated` answers `true` if hypertext reference contains one or more templates
- Representation’s `with(rel:href:)` allows discardable result
- Implement Link equatable using static method
- Merge branch 'feature/string_to_any' into develop
- Allow function bodies of 50 lines before warning
- Oops, SwiftLint requires space around `==`
- Style adjustment: remove space after `==`
- Parser and renderer become Representation methods using `[String: Any]` and `[Any]` Swift types
- Code signing not required for Travis CI

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.3.0...1.0.0)

## [0.3.0](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.3.0) (2017-02-15)

- Merge branch 'feature/swift_package_manager' into develop
- Git ignores build and package products
- Support Swift package manager
- Keep all the shields on one line
- Added SVG image shields to README
- Allow discardable results for `with` methods
- Xcode 8.2 adjustments, including code-sign disabling

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.7...0.3.0)

## [0.2.7](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.7) (2016-08-18)

- Work around bug using KVC setValue(forKey:)

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.6...0.2.7)

## [0.2.6](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.6) (2016-08-18)

- Increase line-length warning and error levels
- Work around `NSMutableDictionary.[]=` bug

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.5...0.2.6)

## [0.2.5](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.5) (2016-08-17)

- Fix change-log entry date
- Revert to copying as Any
- Removed redundant `as Any` cast
- AnyObject to Any

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.4...0.2.5)

## [0.2.4](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.4) (2016-08-17)

- Force down-cast from mutable to non-mutable dictionary after copy
- Swift (Xcode 8 beta 6, swiftlang-800.0.43.6) needs `as AnyObject` down-casts

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.3...0.2.4)

## [0.2.3](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.3) (2016-08-15)

- Property representationsForRel no longer public
- New computed property Representation.representations(for:)
- New computed property Representation.rels
- Use @import syntax
- Simplify method signatures to link(for:), links(for:) and value(for:)

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.2...0.2.3)

## [0.2.2](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.2) (2016-08-12)

- Fix Travis configuration

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.1...0.2.2)

## [0.2.1](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.1) (2016-08-11)

- Representation needs a public initialiser
- Swift let underscore equals to underscore equals

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.2.0...0.2.1)

## [0.2.0](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.2.0) (2016-08-11)

- Renamed sub-folders to Sources and Tests
- Merge branch 'feature/swift_3_0' into develop
- Removed redundant Foundation import
- Convert to Swift 3.0; adds SWIFT_VERSION=3.0

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1.5...0.2.0)

## [0.1.5](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1.5) (2016-07-25)

- Disable SwiftLint errors
- Fix statement position violations (SwiftLint)
- Disable cyclomatic complexity warning
- Xcode 8.x upgrade
- Whole-module optimisation
- Swift 2.3 migration
- Merge branch 'feature/swift_lint' into develop
- Disable valid documentation warnings
- Run SwiftLint
- Xcode automatically removes asset tags

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1.4...0.1.5)

## [0.1.4](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1.4) (2016-03-23)

- Swift 2.2 now includes debugDescription as part of NSObjectProtocol

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1.3...0.1.4)

## [0.1.3](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1.3) (2016-02-08)

- Copyright 2016
- Swift framework not Ruby gem; README fixes

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1.2) (2016-01-01)

- Use nil for default value's default value

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1.1) (2016-01-01)

- Added valueFor(name, defaultValue) method for Representation
- Note about iPhone Simulator
- Use iPhone Simulator 9.1 for tests
- Update xctool on Travis
- Travis wants the Xcode 7.1 project and scheme
- Travis CI configuration
- Jazzy configuration

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1.0...0.1.1)

## [0.1.0](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1.0) (2015-11-14)

- Set up as CocoaPod
- MIT license
- README in Markdown
- Implement debugDescription for Link class
- Fix: appending dictionary-embedded arrays in Swift
- Public links, properties, embedded representations
- Override representation initialiser
- Representation inherits from NSObject
- Make parse and render methods static
- Fix: parse embedded representation

[Full Change Log](https://github.com/royratcliffe/hypertextapplicationlanguage/compare/0.1...0.1.0)

## [0.1](https://github.com/royratcliffe/hypertextapplicationlanguage/tree/0.1) (2015-11-03)

Initial version.
