# Hypertext Application Language (HAL)

What HTML does for web browsers, HAL does for applications.

HTML gives you pages of marked-up information for presentation to users; HAL
gives you marked-up representations for application consumption. Applications
can easily extract information about remote resources, including relationships
between resources. What HAL calls a representation, HTML calls a web page; such
pages have links to other pages. HTML was designed for presenting information
to humans. HAL was designed for presenting information to applications.

This gem provides a suite of Ruby classes for rendering and parsing resource
representations, including their links, properties and nested representations
of embedded resources.

## Deviations

The interfaces and implementations largely echo those written in Java, but
there are some deliberate deviations.

The Ruby gem adds some consistency in naming. Representation is the name used
to describe an object that represents some remote resource. The term “resource”
describes the actual remote resource. Representations represent resources only;
they are not the resource themselves.

The use of “currie” has been replaced as it partially overlaps the idea of
currying and curried functions in mathematics and computer science, when in
fact the term ‘curie’ only refers to a compact URI. The acronym only
coincidentally resembles the word “curry,” a delicious Asian meal.
