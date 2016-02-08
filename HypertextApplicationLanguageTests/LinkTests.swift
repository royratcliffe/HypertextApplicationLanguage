// HypertextApplicationLanguageTests LinkTests.swift
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

// Do not import as testable, i.e. skip the `@testable` keyword prefix when
// importing. It makes the internal interface visible. Such breaks the
// immutability of `Link` attributes because the tests can see the internal
// setters.
import HypertextApplicationLanguage

class LinkTests: XCTestCase {

  let link = Link(rel: "rel", href: "/path/to/rel")

  func testCreate() {
    XCTAssertEqual("rel", link.rel)
    XCTAssertEqual("/path/to/rel", link.href)
  }

  func testMutability() {
    // The following fails. The setters remain inaccessible.
    //
    //    link.rel = "other"
    //
    let otherLink = link.copy() as! Link
    XCTAssertFalse(link === otherLink)
    XCTAssertEqual(otherLink, link)
    XCTAssertEqual("rel", otherLink.rel)
    otherLink.rel = "other"
    XCTAssertEqual("other", otherLink.rel)
  }

  func testEqual() {
    XCTAssertFalse(link.isEqual(nil))
    let otherLink = link.copy() as! Link
    XCTAssertEqual(otherLink, link)
    otherLink.rel = "other"
    XCTAssertNotEqual(otherLink, link)
  }

}
