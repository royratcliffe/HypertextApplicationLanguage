// HypertextApplicationLanguage NSDictionaryRepresentationParser.swift
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

/// An object that parses a representation.
///
/// The parser does not “parse” the dictionary, strictly speaking. Nor does it
/// check the dictionary for strict compliance. Instead it just picks out pieces
/// of the dictionary matching HAL expectations. Nothing more than that.
public class NSDictionaryRepresentationParser {

  /// Parses a dictionary, loading the given representation with its
  /// hypertext-application-language content.
  public static func parse(representation: Representation, object: NSDictionary) {
    // swiftlint:disable:previous cyclomatic_complexity
    // Takes compact URI pairs from the links. Looks for the `curies`
    // sub-dictionary within `_links` root-level dictionary. Every CURIE is a
    // dictionary with a name and a hypertext reference.
    if let linksObject = object[Representation.Links] as? NSDictionary {
      if let curieObjects = linksObject[Link.CuriesRel] {
        for object in NSDictionaryRepresentationParser.objects(from: curieObjects) {
          // Both the name and the hypertext reference must have string type;
          // there is no scope for representing references except using their
          // string form. Represent with strings, otherwise the parser ignores
          // it.
          //
          // The link's `href` attribute carries the relative reference, even
          // though the reference is not a true hypertext reference since it
          // contains the `{rel}` token as a placeholder for substitution.
          guard let name = object[Link.Name] as? String else { continue }
          guard let ref = object[Link.Href] as? String else { continue }
          representation.withNamespace(name: name, ref: ref)
        }
      }

      // The links object is a dictionary of strings paired with a dictionary or
      // an array of dictionaries.
      for (key, value) in linksObject {
        guard let rel = key as? String else { continue }
        if rel == Link.CuriesRel { continue }
        for object in NSDictionaryRepresentationParser.objects(from: value) {
          // The link object requires at least a hypertext reference. All links
          // require a relation and a reference. Other attributes remain
          // optional.
          guard let href = object[Link.Href] as? String else { continue }
          let link = Link(rel: rel, href: href)

          // Makes you wonder. Should the following pass the name? Doing so
          // allows name-spaces to sneak into the links. Name-spaces should only
          // appear in the `curies` dictionary. They will never function as a
          // CURIE unless they do.
          if let name = object[Link.Name] as? String {
            link.name = name
          }

          if let title = object[Link.Title] as? String {
            link.title = title
          }
          if let hreflang = object[Link.Hreflang] as? String {
            link.hreflang = hreflang
          }
          if let profile = object[Link.Profile] as? String {
            link.profile = profile
          }

          representation.withLink(link: link)
        }
      }
    }

    // Properties should only contain primitive types: string, numbers, booleans
    // or arrays of the same.
    for (key, value) in object {
      guard let name = key as? String else { continue }
      if [Representation.Links, Representation.Embedded].contains(name) { continue }
      representation.withProperty(name: name, value: value)
    }

    if let embedded = object[Representation.Embedded] as? NSDictionary {
      for (key, value) in embedded {
        guard let rel = key as? String else { continue }
        // The relation key must be a string. Turn the value into an array of
        // dictionaries, parsing an embedded representation from each
        // dictionary.
        for object in NSDictionaryRepresentationParser.objects(from: value) {
          let embeddedRepresentation = Representation()
          parse(representation: embeddedRepresentation, object: object)
          representation.withRepresentation(rel: rel, representation: embeddedRepresentation)
        }
      }
    }
  }

  /// Given any object, extracts an array of dictionary objects. Any object is
  /// either a dictionary or an array. Ignores non-dictionary objects. If the
  /// given object is not a dictionary, or is not an array, then the answer is
  /// an empty array of dictionary objects.
  private static func objects(from: AnyObject) -> [NSDictionary] {
    var objects = [NSDictionary]()
    switch from {
    case let array as NSArray:
      for element in array {
        guard let object = element as? NSDictionary else { continue }
        objects.append(object)
      }
    case let object as NSDictionary:
      objects.append(object)
    default:
      break
    }
    return objects
  }

}
