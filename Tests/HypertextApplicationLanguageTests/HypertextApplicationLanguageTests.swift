// HypertextApplicationLanguageTests HypertextApplicationLanguageTests.swift
//
// Copyright © 2015, 2016, 2017, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

import XCTest
@testable import HypertextApplicationLanguage

class HypertextApplicationLanguageTests: XCTestCase {

  /// Loads and returns a string from a JSON string file located within the test
  /// bundle. Fails (with a bang) if it cannot find the corresponding resource.
  func data(forJSONResource name: String) -> Data {
    let bundle = Bundle(for: type(of: self))
    let url = bundle.url(forResource: name, withExtension: "json") ?? URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("Fixtures", isDirectory: true)
      .appendingPathComponent(name)
      .appendingPathExtension("json")
    // swiftlint:disable:next force_try
    return try! Data(contentsOf: url)
  }

  func jsonObject(forResource name: String, options: JSONSerialization.ReadingOptions = []) -> Any {
    // swiftlint:disable:next force_try
    return try! JSONSerialization.jsonObject(with: data(forJSONResource: name), options: options)
  }

  static let RootURLString = "https://example.com"
  static let BaseURLString = RootURLString + "/api/"

  static func newBaseRepresentation(path: String) -> Representation {
    return Representation()
      .with(rel: Link.SelfRel, href: BaseURLString + path)
      .with(name: "ns", ref: RootURLString + "/apidocs/ns/" + NamespaceManager.Rel)
      .with(name: "role", ref: RootURLString + "/apidocs/role/" + NamespaceManager.Rel)
      .with(link: Link(rel: "ns:parent", href: BaseURLString + "customer/1234")
        .with(name: "bob")
        .with(title: "The Parent")
        .with(hreflang: "en"))
  }

}
