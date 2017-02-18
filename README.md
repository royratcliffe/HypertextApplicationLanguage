[![Travis](https://img.shields.io/travis/royratcliffe/HypertextApplicationLanguage/master.svg)](https://travis-ci.org/royratcliffe/HypertextApplicationLanguage)
[![CocoaPods](https://img.shields.io/cocoapods/v/HypertextApplicationLanguage.svg)](https://cocoapods.org/pods/HypertextApplicationLanguage)
[![CocoaDocs](https://img.shields.io/cocoapods/metrics/doc-percent/HypertextApplicationLanguage.svg)](http://cocoadocs.org/docsets/HypertextApplicationLanguage)

# Hypertext Application Language (HAL)

What HTML does for web browsers, HAL does for applications.

HTML gives you pages of marked-up information for presentation to users; HAL
gives you marked-up representations for application consumption. Applications
can easily extract information about remote resources, including relationships
between resources. What HAL calls a representation, HTML calls a web page; such
pages have links to other pages. HTML was designed for presenting information
to humans. HAL was designed for presenting information to applications.

This framework provides a suite of Swift classes for rendering and parsing resource
representations, including their links, properties and nested representations
of embedded resources.

## What Can You Do With It?

The framework lets you encode and decode HAL representations. Representations
internally render and parse via dictionaries, or `[String: Any]` types in Swift,
but can code between other types via the dictionary. So for example, you can
construct JSON strings from `Representation` instances, and vice versa.

To start with, you can easily construct a resource representation and configure
it with links, embedded representations and properties. The following example
constructs a ficticious customer resource.

```swift
let representation = Representation()
  .with(rel: Link.SelfRel, href: "https://example.com/api/customer/123456")
  .with(name: "ns", ref: "https://example.com/apidocs/ns/" + NamespaceManager.Rel)
  .with(name: "role", ref: "https://example.com/apidocs/role/" + NamespaceManager.Rel)
  .with(link: Link(rel: "ns:parent", href: "https://example.com/api/customer/1234")
    .with(name: "bob")
    .with(title: "The Parent")
    .with(hreflang: "en"))
  .with(rel: "ns:users", href: "https://example.com/api/customer/123456?users")
  .with(name: "id", value: 123456)
  .with(name: "age", value: 33)
  .with(name: "name", value: "Example Resource")
  .with(name: "optional", value: true)
  .with(name: "expired", value: false)
```

This extract shows the use of cascading `with` methods for configuring a
representation. But the `Representation` and `Link` classes also provide more
conventional methods for loading their attributes with values.
 
Converting a representation to JSON is easy.

```swift
try! representation.jsonString(options: .prettyPrinted)!
```

Notice the `try`. Converting to JSON throws an error if `JSONSerialization`
fails. Notice also the 'bang' for the optional string result, which can produce
`nil` if the JSON data fails to convert to a UTF-8 string for any reason.

The `jsonString(options:)` method produces a string containing JSON-encoded
hypertext application language, as follows:

```json
{
  "optional" : true,
  "age" : 33,
  "name" : "Example Resource",
  "id" : 123456,
  "expired" : false,
  "_links" : {
    "self" : {
      "href" : "https://example.com/api/customer/123456"
    },
    "curies" : [
      {
        "name" : "ns",
        "templated" : true,
        "href" : "https://example.com/apidocs/ns/{rel}"
      },
      {
        "name" : "role",
        "templated" : true,
        "href" : "https://example.com/apidocs/role/{rel}"
      }
    ],
    "ns:parent" : {
      "name" : "bob",
      "title" : "The Parent",
      "href" : "https://example.com/api/customer/1234",
      "hreflang" : "en"
    },
    "ns:users" : {
      "href" : "https://example.com/api/customer/123456?users"
    }
  }
}
```

Notice that the string does *not* escape the forward slashes.

Converting this back to a representation is also very simple. Assuming the
JSON-encoded string is in a variable called `string`, then the following
expression constructs a new representation object from the JSON string.

```swift
try! Representation.from(json: string.data(using: String.Encoding.utf8)!)
```

The result matches the original. Of course, you would catch the errors and guard
the optionals in a real application.

## Deviations

The interfaces and implementations largely echo those written in Java, but
there are some deliberate deviations.

The Swift framework adds some consistency in naming. Representation is the name used
to describe an object that represents some remote resource. The term “resource”
describes the actual remote resource. Representations represent resources only;
they are not the resource themselves.

The use of “currie” has been replaced as it partially overlaps the idea of
currying and curried functions in mathematics and computer science, when in
fact the term ‘curie’ only refers to a compact URI. The acronym only
coincidentally resembles the word “curry,” a delicious Asian meal.
