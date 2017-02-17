// HypertextApplicationLanguage Link.swift
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

import Foundation

/// Links belong to representations; a representation retains zero or more
/// links. Each link gives a hypertext reference for a relation, at least. Some
/// links provide more information.
///
/// Links have attributes. The relation and hypertext reference attributes are
/// primary and are always required for every link. Representations may carry
/// multiple links with the *same* relation, just like a HTML page. Links
/// sharing the same relation refer to the same thing, or things.
///
/// This is the simplest possible implementation of a
/// hypertext-application-language (HAL) link. It does not support
/// immutability. All links and their attributes remain mutable, even after
/// attaching to a representation.
public struct Link {

  /// Creates a new mutable link.
  /// - returns: Answers a newly initialised link.
  /// - parameter rel: Relation.
  /// - parameter href: Hypertext reference.
  public init(rel: String, href: String) {
    self.rel = rel
    self.href = href
  }

  // Required attributes

  public var rel: String

  /// Link attribute describing the hypertext reference. The reference can be a
  /// full universal resource location, or some element thereof. It can be just
  /// the path.
  public var href: String

  /// Works out if the link comprises a template form of reference. True if the
  /// link's hypertext reference contains at least one template pattern.
  public var templated: Bool {
    struct Templated {
      // swiftlint:disable:next force_try
      static let expression = try! NSRegularExpression(pattern: "\\{.+\\}")
    }
    let range = NSRange(location: 0, length: href.characters.count)
    return Templated.expression.numberOfMatches(in: href, range: range) > 0
  }

  // Optional attributes

  public var name: String?
  public var title: String?

  /// Gives the ISO 639-1 code describing the link's language. You can have
  /// multiple links for the same relation but for different languages.
  public var hreflang: String?

  public var profile: String?

  /// Constructs a new link based on this link but with the name changed.
  /// - parameter name: Optional name to replace any existing name.
  public func with(name: String?) -> Link {
    var link = self
    link.name = name
    return link
  }

  public func with(title: String?) -> Link {
    var link = self
    link.title = title
    return link
  }

  public func with(hreflang: String?) -> Link {
    var link = self
    link.hreflang = hreflang
    return link
  }

  public func with(profile: String?) -> Link {
    var link = self
    link.profile = profile
    return link
  }

  // Required link attribute names

  public static let Rel = "rel"
  public static let Href = "href"

  // Optional link attribute names

  public static let Name = "name"
  public static let Title = "title"
  public static let Hreflang = "hreflang"
  public static let Profile = "profile"
  public static let Templated = "templated"

  /// Array of attribute names including those required and those optional.
  public static let AttributeNames = [
    // required
    Rel,
    Href,

    // optional
    Name,
    Title,
    Hreflang,
    Profile,
    Templated,
  ]

  // Special link relations

  /// This special link relation describes the link to the representations own
  /// source, i.e. itself.
  public static let SelfRel = "self"

  /// Special link relation used for name-spaces. Representation name-spaces
  /// appear in rendered links under the "curies" relation; where the link
  /// `name` corresponds to the name-space name and the link `href` corresponds
  /// to the name-space reference with its embedded `{rel}` placeholder.
  public static let CuriesRel = "curies"

}
