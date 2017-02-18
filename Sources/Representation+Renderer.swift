// HypertextApplicationLanguage Representation+Renderer.swift
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

import Foundation

extension Representation {

  /// Renders a representation to a dictionary.
  /// - returns: The resulting dictionary representation.
  public func render() -> [String: Any] {
    return render(embedded: false)
  }

  /// Renders either a top-level representation or an embedded resource.
  private func render(embedded: Bool) -> [String: Any] {
    // swiftlint:disable:previous cyclomatic_complexity
    var object = [String: Any]()

    // Render the name-spaces and links but only if there are name-spaces and
    // links; also render links if there are name-spaces to render, assuming not
    // embedded. Create a dictionary representation without links if there are
    // none. Merge the name-spaces and links.
    if !(links.isEmpty && (embedded || namespaces.isEmpty)) {
      var linksObject = [String: Any]()
      var links = [Link]()
      if !embedded {
        for (name, ref) in namespaces {
          var link = Link(rel: Link.CuriesRel, href: ref)
          link.name = name
          links.append(link)
        }
      }
      links.append(contentsOf: self.links)
      var linksForRel = [String: [Link]]()
      for link in links {
        if var links = linksForRel[link.rel] {
          links.append(link)
          linksForRel[link.rel] = links
        } else {
          linksForRel[link.rel] = [link]
        }
      }
      for (rel, links) in linksForRel {
        let linkObjects = links.map { link -> Any in
          // Render a link as a dictionary. Importantly, the following does not
          // render the link relation; it only renders the link content. The
          // relation appears in the rendered output as the key, not as part of
          // the dictionary value paired with the key.
          var linkObject = [String: Any]()
          linkObject[Link.Href] = link.href

          if let name = link.name {
            linkObject[Link.Name] = name
          }
          if let title = link.title {
            linkObject[Link.Title] = title
          }
          if let hreflang = link.hreflang {
            linkObject[Link.Hreflang] = hreflang
          }
          if let profile = link.profile {
            linkObject[Link.Profile] = profile
          }
          if link.templated {
            linkObject[Link.Templated] = true
          }

          return linkObject
        }
        linksObject[rel] = linkObjects.count == 1 ? linkObjects.first : linkObjects
      }
      object[Representation.Links] = linksObject
    }

    // Merge the representation's properties. Properties live at the root of the
    // dictionary. Merging is just another way to assign values to their name
    // keys.
    //
    // This makes some assumptions about the representation properties. It
    // assumes that the property values are primitive types: strings, numbers,
    // booleans. They should never be dictionaries or custom classes.
    for (name, value) in properties {
      object.updateValue(value, forKey: name)
    }

    // Render embedded resource representations. Each representation retains
    // zero or more sub-representations by their relation. The relation maps to
    // an array of embedded representations, zero or more for each
    // relation. Render each one recursively.
    if !representations.isEmpty {
      var embeddedObject = [String: Any]()
      for (rel, representations) in representationsForRel {
        let objects = representations.map { representation in
          representation.render(embedded: true)
        }
        embeddedObject[rel] = objects.count == 1 ? objects.first : objects
      }
      object[Representation.Embedded] = embeddedObject
    }

    return object
  }

}
