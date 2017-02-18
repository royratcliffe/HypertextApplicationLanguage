// HypertextApplicationLanguage Representation+JSON.swift
//
// Copyright © 2017, Roy Ratcliffe, Pioneering Software, United Kingdom
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

import Foundation

extension Representation {

  /// Deserialises the given data as JSON and parses the successful result,
  /// merging the results into this representation.
  /// - parameter data: JSON-encoded block of data from which to extract the
  ///   representation.
  /// - parameter options: JSON deserialisation options.
  /// - throws: If it fails to deserialise the data.
  /// - returns: This representation.
  @discardableResult
  public func from(json data: Data, options: JSONSerialization.ReadingOptions = []) throws -> Representation {
    if let object = try JSONSerialization.jsonObject(with: data, options: options) as? [String: Any] {
      parse(object: object)
    }
    return self
  }

  /// Constructs a new representation based on the given JSON-encoded data.
  /// - parameter data: JSON-encoded data from which to extract a representation.
  /// - parameter options: JSON deserialisation options.
  /// - throws: Error if the Foundation framework fails to deserialise the data.
  /// - returns: New representation. The representation is empty if the
  ///   deserialised JSON object contains no valid links, embedded
  ///   representations, or properties.
  public static func from(json data: Data, options: JSONSerialization.ReadingOptions = []) throws -> Representation {
    return try Representation().from(json: data, options: options)
  }

  /// Renders and serialises this representation as JSON.
  /// - parameter options: JSON serialisation options.
  public func jsonData(options: JSONSerialization.WritingOptions = []) throws -> Data {
    return try JSONSerialization.data(withJSONObject: render(), options: options)
  }

  /// Renders a JSON string, removing the escapes on all forward slashes. Throws
  /// if JSON serialisation fails to successfully convert the rendered
  /// string-to-any dictionary intermediate representation. Answers `nil` if the
  /// serialised JSON data fails to convert to a UTF-8 string.
  /// - parameter options: JSON serialisation options.
  /// - returns: String containing JSON-encoded rendering of this representation.
  /// - throws: An error if JSON serialisation fails.
  public func jsonString(options: JSONSerialization.WritingOptions = []) throws -> String? {
    let data = try jsonData(options: options)
    return String(data: data, encoding: String.Encoding.utf8)?.replacingOccurrences(of: "\\/", with: "/")
  }

}
