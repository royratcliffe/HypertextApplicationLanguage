// HypertextApplicationLanguage Representation.swift
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

/// Represents a resource. This includes sub-resources which also have their own
/// representation. Representations have links, properties and sub-resources.
///
/// Resource is the name of a representation embedded within another
/// super-representation. Representations have zero or resources. They will
/// appear in the rendered results as embedded resources.
public class Representation {

  public static let Links = "_links"

  public static let Embedded = "_embedded"

  let namespaceManager = NamespaceManager()

  public init() {}

  public var links = [Link]()

  public var properties = [String: Any]()

  /// Dictionary of string-array pairs. The arrays contain embedded
  /// representations, zero or more.
  var representationsForRel = [String: [Representation]]()

  /// All the relations embedded within this representation.
  public var rels: [String] {
    return Array(representationsForRel.keys)
  }

  // MARK: - Namespaces

  public var namespaces: [String: String] {
    return namespaceManager.namespaces
  }

  @discardableResult
  public func with(name: String, ref: String) -> Representation {
    namespaceManager.with(name: name, ref: ref)
    return self
  }

  // MARK: - Links

  public var link: Link? {
    return link(for: Link.SelfRel)
  }

  public func link(for hrefOrRel: String) -> Link? {
    return links(for: hrefOrRel).first
  }

  /// Answers the representation's links selected by either a hypertext
  /// reference or by a relation.
  public func links(for hrefOrRel: String) -> [Link] {
    let rel = namespaceManager.curie(href: hrefOrRel) ?? hrefOrRel
    return links.filter { $0.rel == rel }
  }

  /// Adds a link to this representation.
  @discardableResult
  public func with(link: Link) -> Representation {
    links.append(link)
    return self
  }

  @discardableResult
  public func with(rel: String, href: String) -> Representation {
    return with(link: Link(rel: rel, href: href))
  }

  // MARK: - Properties

  public func value(for name: String, defaultValue: Any? = nil) -> Any? {
    return properties[name] ?? defaultValue
  }

  @discardableResult
  public func with(name: String, value: Any) -> Representation {
    properties[name] = value
    return self
  }

  // MARK: - Representations

  /// Takes the array values from the representations by relation, then flattens
  /// the array of arrays of representations. The result becomes an array of
  /// representations, all of them but without their relation to the
  /// super-representation that having been stripped away.
  public var representations: [Representation] {
    return representationsForRel.values.flatMap { $0 }
  }

  /// - parameter rel: Relation name.
  /// - returns: Embedded representations for the given relation. Answers `nil`
  ///   if the relation does not exist.
  public func representations(for rel: String) -> [Representation]? {
    return representationsForRel[rel]
  }

  /// Associates a given embedded representation with this representation by a
  /// given relation.
  @discardableResult
  public func with(rel: String, representation: Representation) -> Representation {
    if var representations = representationsForRel[rel] {
      representations.append(representation)
      // In Swift, the original dictionary accessor answers with a copy of the
      // array, not the array within the dictionary itself. Therefore take a
      // mutable copy and reassign the dictionary entry after appending the new
      // embedded representation.
      representationsForRel[rel] = representations
    } else {
      representationsForRel[rel] = [representation]
    }
    return self
  }

}
