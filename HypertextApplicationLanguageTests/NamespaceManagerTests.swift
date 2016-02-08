// HypertextApplicationLanguageTests NamespaceManagerTests.swift
//
// Copyright © 2015, 2016, Roy Ratcliffe, Pioneering Software, United Kingdom
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

class NamespaceManagerTests: XCTestCase {

  let manager = NamespaceManager()

  func testInit() {
    XCTAssertNotNil(manager)
    XCTAssertTrue(manager.namespaces.isEmpty)
    XCTAssertEqual(0, manager.namespaces.count)

    // Name-spaces are get-only properties. You cannot assign through a
    // subscript, as follows.
    //
    //    manager.namespaces["name"] = "href"
    //
    // However, you *can* copy the name-spaces and change the result. Doing so
    // never alters the original name-space manager though: you just copy a
    // string-string map. Do with that whatever you will.
    var namespaces = manager.namespaces
    namespaces["name"] = "href"
    XCTAssertEqual(0, manager.namespaces.count)
  }

  func testWithNamespace() {
    XCTAssertEqual(0, manager.namespaces.count)
    manager.withNamespace("name", ref: "http://localhost/" + NamespaceManager.Rel)
    XCTAssertEqual("http://localhost/{rel}", manager.namespaces["name"])
    XCTAssertEqual(1, manager.namespaces.count)
  }

  let nsManager = NamespaceManager().withNamespace("ns", ref: "http://localhost/{rel}/to")

  func testCurieForHref() {
    XCTAssertEqual("ns:path", nsManager.curie("http://localhost/path/to"))
    XCTAssertNil(nsManager.curie("http://localhost:8080/to"))
  }

  func testHrefForCurie() {
    XCTAssertEqual("http://localhost/arg/to", nsManager.href("ns:arg"))
    XCTAssertNil(nsManager.href("n$:arg"))
  }

}
