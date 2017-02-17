// HypertextApplicationLanguageTests RepresentationTests.swift
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
import HypertextApplicationLanguage

class RepresentationTests: HypertextApplicationLanguageTests {

  /// Renders an empty representation (no links, no properties, no embedded
  /// representations) to JSON. Checks that the result is an empty JSON object:
  /// open and close brace.
  func testEmpty() {
    // given
    let representation = Representation()
    // when
    // swiftlint:disable:next force_try
    let string = String(data: try! representation.jsonData(), encoding: String.Encoding.utf8)!
    // then
    XCTAssertEqual(string, "{}")
  }

  func testSelfLink() {
    // given
    let representation = Representation().with(rel: Link.SelfRel, href: "http://localhost/path/to/self")
    // when
    // swiftlint:disable:next force_try
    let string = try! representation.jsonString()!
    // then
    XCTAssertEqual(string, "{\"_links\":{\"self\":{\"href\":\"http://localhost/path/to/self\"}}}")
  }

  func testCustomer123456() {
    // given
    let path = "customer/123456"
    let representation = type(of: self).newBaseRepresentation(path: path)
    // when
    representation
      .with(rel: "ns:users", href: type(of: self).BaseURLString + path + "?users")
      .with(name: "id", value: 123456)
      .with(name: "age", value: 33)
      .with(name: "name", value: "Example Resource")
      .with(name: "optional", value: true)
      .with(name: "expired", value: false)
    // then
    // swiftlint:disable:next force_cast
    XCTAssertEqual(representation.render() as NSDictionary, jsonObject(forResource: "example") as! NSDictionary)
  }

}
